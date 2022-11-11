import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/detailedReport.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => Report_Form();
}

class Report_Form extends State<ReportPage> {

  int actual = 1;
  List<Icon> serviceIcons = [
    const Icon(Icons.gas_meter_rounded, color: Colors.black),
    const Icon(Icons.water_drop, color: Colors.black),
    const Icon(Icons.lightbulb, color: Colors.black)
  ];
  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();
    UserController user = Get.find<UserController>();
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
            if (report.idUsuario == user.id)
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: serviceIcons[report.bitmap],
                      title: Text(report.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(report.state.toString().split('.').last),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Ver'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailReportPage(report),
                              ));
                              },
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
                    SizedBox(height: 10,)
                  ],
                ),
              ),
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
