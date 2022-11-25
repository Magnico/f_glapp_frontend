import 'package:f_shopping_app/ui/Widgets/fnavBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/detailedReport.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/nuevoReporte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => Report_Form();
}

class Report_Form extends State<ReportPage> {
  int actual = 1;
  List serviceIcons = [
    SvgPicture.asset('images/gasIcon.svg'),
    SvgPicture.asset('images/waterIcon.svg'),
    SvgPicture.asset('images/energyIcon.svg'),
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
        backgroundColor: const Color.fromARGB(255, 88, 154, 220),
      ),
      body: ListView(
        children: [
          // todo make it dynamically like at home page map
          for (var report in con.getReports())
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: serviceIcons[report.bitmap],
                    title: Text(report.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: FBNavigationBar(actual, this),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewReport()),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     backgroundColor: Color.fromARGB(255, 173, 208, 244),
    );
  }
}
