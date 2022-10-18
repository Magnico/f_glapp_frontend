import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);
  
  @override
  State<Report> createState() => Report_Form();
  
}

class Report_Form extends State<Report> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: Icon(Icons.menu),
        title: Text('Mis Reportes'),
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Color.fromARGB(255, 48, 105, 219),
      ),
      bottomNavigationBar: BottomAppBar(
    child: Row(
      children: [
        IconButton(icon: Icon(Icons.home), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
           );
        }),
        Spacer(),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    ),
  ),
  floatingActionButton:
      FloatingActionButton(child: Icon(Icons.add), onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewReport()),
           );
      }),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

}