import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/providerController.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => Report_Form();
}

class Report_Form extends State<Report> {
  int actual = 1;
  List<Icon> serviceIcons = [
    const Icon(Icons.gas_meter_rounded, color: Colors.black),
    const Icon(Icons.water_drop, color: Colors.black),
    const Icon(Icons.lightbulb, color: Colors.black)
  ];
  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis reportes"),
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
      body: ListView(
        children: [
          // todo make it dynamically like at home page map
          for (var report in con.reportes)
            Expanded(
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: serviceIcons[report.bitmap],
                      title: Text(report.title),
                      subtitle: Text(report.state.toString().split('.').last),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Ver'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('Eliminar'),
                          onPressed: () async {
                            await con.delteReport(report.id);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
      bottomNavigationBar: BNavigationBar(actual, this),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewReport()),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
