import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:f_shopping_app/ui/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class FBNavigationBar extends StatelessWidget {
  FBNavigationBar(this.actual, this.reference, {Key? key}) : super(key: key);

  var reference;

  List<Widget> paginas = [
    HomePage(),
    ReportPage(),
    ProfilePage(),
  ];

  int actual;

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      backgroundColor: Color(0xFF045DB9),
      selectedItemColor: Color(0xFFF0DD7C),
      selectedBackgroundColor: Color(0xFF045DB9),
      onTap: (value) {
        // Respond to item press.
        reference.setState(() {
          actual = value;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => paginas[actual]),
        );
      },
      currentIndex: actual,
        items: [
          FloatingNavbarItem(icon: Icons.home_filled,),
          FloatingNavbarItem(icon: Icons.info_rounded),
          FloatingNavbarItem(icon: Icons.person),
        ],
      );
  }
}
