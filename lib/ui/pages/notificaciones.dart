import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/providerController.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => NotificationPage_Form();
}

class NotificationPage_Form extends State<NotificationPage> {
  int actual = 2;

  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Notificaciones"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }),
        backgroundColor: const Color.fromARGB(255, 47, 91, 223),
      ),
      body: ListView(),
      bottomNavigationBar: BNavigationBar(actual, this),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewReport()),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
