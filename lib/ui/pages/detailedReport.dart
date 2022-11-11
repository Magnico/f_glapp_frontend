import 'package:f_shopping_app/domain/report.dart';
import 'package:f_shopping_app/domain/states.dart';
import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailReportPage extends StatefulWidget {
  var reporte;
  DetailReportPage(this.reporte, {Key? key}) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<DetailReportPage>{
  int actual = 3;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();
    var reporte = widget.reporte;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte - ${reporte.id}"),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportPage()),
           );
        }),
        backgroundColor: const Color.fromARGB(255, 47, 91, 223),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(con.getIcon(reporte.bitmap), color: Colors.black, size:70,),
                Column(
                  children: [
                    Text(reporte.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    Divider(height: 10),
                    Text(reporte.date.toString().substring(0, 10) + " " + reporte.date.toString().substring(11, 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                ListTile(
                  leading: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(getStateIcon(reporte.state), color: Colors.black)]),
                  title: Text("Estado "),
                  subtitle: Text("${reporte.state.toString().split('.').last}"),
                ),
              ],
            ),
            //tarjeta con la descripción
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Descripción"),
                    subtitle: Text(reporte.desc),
                  ),
                ],
              ),
            ),
            Center(
              child: Text("Historial de estados", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var event in reporte.history)
                  Card(
                    //sombra de la tarjeta mas oscura
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(getStateIcon(event["state"]), color: Colors.black)]),
                          title: Text("${event["state"].toString().split('.').last} - ${event["eventDate"].toString().substring(0, 10)} ${event["eventDate"].toString().substring(11, 16)}"),
                        ),
                        ListTile(
                          title: Text("Comentario"),
                          subtitle: Text(event["comment"]),
                        ),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BNavigationBar(actual, this),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
}

IconData getStateIcon(state) {
  switch (state) {
    case ReportState.Publicado:
      return Icons.publish;
    case ReportState.Pendiente:
      return Icons.access_time_outlined;
    case ReportState.Revision:
      return Icons.remove_red_eye_outlined;
    case ReportState.Rechazado:
      return Icons.cancel_outlined;
    case ReportState.Solucionado:
      return Icons.check_circle_outline;
    default:
      return Icons.abc;
  }
}
