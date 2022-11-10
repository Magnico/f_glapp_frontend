import 'dart:async';
import 'dart:developer';

import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

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
  Timer? _debounce;

  DetailsResult? _placeDetails;
  late FocusNode _searchFocusNode;

  //initializing the reports icons map
  void loadReportsIcons() async {
    IconSet[0] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    IconSet[1] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    IconSet[2] =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    /*
      IconSet[0] = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'images/water.png');
      IconSet[1] = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'images/light.png');
      IconSet[2] = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), 'images/gas.png');
    */
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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 47, 91, 223),
        //cuando retorne a la pantalla principal, dispose el controlador
        automaticallyImplyLeading: false,
        actions: [
          //search field
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              focusNode: _searchFocusNode,
              controller: searchTextController,
              decoration: const InputDecoration(
                hintText: 'Ingrese su ubicación',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    autocompleteSearch(value);
                  } else {
                    setState(() {
                      _places = [];
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          FloatingActionButton(
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: _places.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(_places[index].description!.toString()),
                onTap: () async {
                  final placeId = _places[index].placeId;
                  final details = await _googlePlace.details.get(placeId!);
                  if (details != null && details.result != null && mounted) {
                    if (_searchFocusNode.hasFocus) {
                      setState(() {
                        _placeDetails = details.result;
                        searchTextController.text = _placeDetails!.name!;
                        //usar placeDetails para obtener la ubicación
                        currentLocation = LatLng(
                            _placeDetails!.geometry!.location!.lat!,
                            _placeDetails!.geometry!.location!.lng!);
                        con.changeLocation(currentLocation);
                        _places = [];
                        _searchFocusNode.unfocus();
                      });
                      focusMap();
                    }
                  }
                },
              );
            },
          ),
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
