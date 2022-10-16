import 'package:f_shopping_app/ui/pages/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Widgets/banner.dart';
import '../Widgets/cart_total.dart';

const LatLng currentLocation = LatLng(25.1193, 55.3773);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => HomeState();
  
}

class HomeState extends State<HomePage>{
@override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: currentLocation,)),
        );
  }
}