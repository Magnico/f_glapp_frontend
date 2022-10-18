import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:f_shopping_app/ui/pages/usuario.dart';
import 'package:google_place/google_place.dart';

LatLng currentLocation = LatLng(25.1193, 55.3773);
final Completer<GoogleMapController> _controller = Completer();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  //set custom marker pins
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  int actual = 0;

  late GooglePlace _googlePlace;
  List<AutocompletePrediction> _places = [];
  final searchTextController = TextEditingController();
  Timer? _debounce;

  List<Widget> paginas = [
    HomePage(),
    Report(),
    HomePage(),
    Usuario(),
  ];

  //initializing the source and destination markers
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'images/marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'images/marker.png');
  }

  //ejecutar _determinePosition() cuando se inicie el estado
  @override
  void initState() {
    super.initState();
    _determinePosition();
    String apiKey = 'AIzaSyB9NLDNfBdWb-PPUa9e-q6FzTP8xrranAI';
    _googlePlace = GooglePlace(apiKey);
    
  }

  autocompleteSearch(String value) async{
    var result = await _googlePlace.autocomplete.get(value);
    if(result!= null && result.predictions!=null && mounted){
      print(result.predictions!.first.description);
      setState(() {
        _places = result.predictions!;
      });
    }
  }

  Future<void> _determinePosition() async {
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
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _determinePosition();
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocation, zoom: 3)));
        },
        child: const Icon(Icons.location_searching),
      ),
      body:  Stack(
        children: [
          TextField(
            controller: searchTextController,
            autofocus: false,
            decoration: const InputDecoration(
              hintText: 'Buscar',
              hintStyle: TextStyle(color: Colors.red),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.red,
              ),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                if (value.isNotEmpty) {
                  autocompleteSearch(value);
                }
              });
              
            },
            ),
          GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: currentLocation, zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setSourceAndDestinationIcons();
        },
        markers: <Marker>{
          Marker(
            draggable: true,
            markerId: const MarkerId("1"),
            position: currentLocation,
            icon: sourceIcon,
            infoWindow: const InfoWindow(
              title: 'My Location',
            ),
          )
        },
      )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 47, 91, 223),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
          setState(() {
            actual = value;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => paginas[actual]),
          );
        },
        currentIndex: actual,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Reportes',
            icon: Icon(Icons.receipt),
          ),
          BottomNavigationBarItem(
            label: 'Places',
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
  
}
