import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:f_shopping_app/ui/pages/profile.dart';
import 'package:flutter/material.dart';

class BNavigationBar extends StatelessWidget {
  BNavigationBar(this.actual, this.reference, {Key? key}) : super(key: key);
  
  var reference;

  List<Widget> paginas = [
    HomePage(),
    Report(),
    HomePage(),
    ProfilePage(),
  ];
  int actual;
  //Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 47, 91, 223),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
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
          label: 'Notificaciones',
          icon: Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          label: 'Perfil',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
