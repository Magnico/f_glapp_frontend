import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/pages/login.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../domain/report.dart';

LatLng currentLocation = const LatLng(0, 0);
final Completer<GoogleMapController> _controller = Completer();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  //set custom marker pins
  List<BitmapDescriptor> IconSet = [
    BitmapDescriptor.defaultMarker,
    BitmapDescriptor.defaultMarker,
    BitmapDescriptor.defaultMarker
  ];
  int actual = 0;

  late GooglePlace _googlePlace;
  List<AutocompletePrediction> _places = [];
  final searchTextController = TextEditingController();
  late FocusNode _searchFocusNode;

  //initializing the reports icons map
  void loadReportsIcons() async {
    IconSet[0] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    IconSet[1] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    IconSet[2] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
  }

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyB9NLDNfBdWb-PPUa9e-q6FzTP8xrranAI';
    _googlePlace = GooglePlace(apiKey);

    loadActualPosition();
    loadReportsIcons();

    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose();
    _controller.future.then((controller) => controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();
    con.changeLocation(currentLocation);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewReport()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
              child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: currentLocation, zoom: 15),
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            },
            markers: <Marker>{
              Marker(
                draggable: false,
                markerId: const MarkerId("ME"),
                position: currentLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                infoWindow: const InfoWindow(
                  title: 'Mi Ubicación',
                ),
              ),
              // todo actualizar la lista de reportes de manera dinamica con obx
              for (var report in con.reportes)
                Marker(
                  draggable: false,
                  markerId: MarkerId(report.id.toString()),
                  position: report.location,
                  icon: IconSet[report.bitmap],
                  infoWindow: InfoWindow(
                    title: report.title, 
                    snippet: report.state.toString().split('.').last,
                    onTap: () => log(report.location.toString()),
                  ),
                ),
            },
          ))
        ],
      ),
      bottomNavigationBar: BNavigationBar(actual, this),
    );
  }

  autocompleteSearch(String value) async {
    var result = await _googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        _places = result.predictions!;
      });
    }
  }

  Future<void> loadActualPosition() async {
    // Test if location services are enabled.
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    focusMap();
    return;
  }

  void focusMap() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 15)));
  }
}
