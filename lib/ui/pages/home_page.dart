import 'package:f_shopping_app/ui/pages/product_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Widgets/banner.dart';
import '../Widgets/cart_total.dart';
import 'package:f_shopping_app/ui/pages/sign_up.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:f_shopping_app/ui/pages/usuario.dart';
const LatLng currentLocation = LatLng(25.1193, 55.3773);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => HomeState();
  
}

class HomeState extends State<HomePage>{
 int actual =0;
 List<Widget>paginas =[
  HomePage(),
  Report(),
  HomePage(),
  Usuario(),

  
 ];
 @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: 
      Column(
        children: [
          GoogleMap(initialCameraPosition: CameraPosition(target: currentLocation,)),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF6200EE),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (value) {
              // Respond to item press.
              setState(() {
                actual= value;
              });
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => paginas[actual]),
                      );
            },
            currentIndex: actual,
            items: [
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
          )
        ],
      ) 
        );
  }
}