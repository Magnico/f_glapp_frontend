import 'package:f_shopping_app/domain/report.dart';
import 'package:f_shopping_app/domain/reportState.dart';
import 'package:f_shopping_app/domain/states.dart';
import 'package:f_shopping_app/ui/Widgets/navBar.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/domain/states.dart';
import 'package:f_shopping_app/ui/pages/reportes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailReportPage extends StatefulWidget {
  Report reporte;
  DetailReportPage(this.reporte, {Key? key}) : super(key: key);
  TextEditingController desc = TextEditingController();
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<DetailReportPage> {
  int actual = 3;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();
    UserController user = Get.find<UserController>();
    bool _isEnterprise = user.rol == 0;
    ReportStates _toState;
    var reporte = widget.reporte;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte - ${reporte.id}"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  con.getIcon(reporte.bitmap),
                  color: Colors.black,
                  size: 70,
                ),
                Column(
                  children: [
                    Text(
                      reporte.title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Divider(height: 10),
                    Text(reporte.date.toString().substring(0, 10) +
                        " " +
                        reporte.date.toString().substring(11, 16)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ListTile(
                  leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(getStateIcon(reporte.state), color: Colors.black)
                      ]),
                  title: Text("Estado "),
                  subtitle: Text("${reporte.state.toString().split('.').last}"),
                ),
              ],
            ),
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
            Visibility(
              visible: _isEnterprise,
              child: Container(
                child: Row(
                  children: [
                        Icon(
                          Icons.change_circle_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(width: 20,),
                        DropdownButton(
                          items: [ReportStates.Publicado, 
                          ReportStates.Pendiente, 
                          ReportStates.Revision, 
                          ReportStates.Rechazado, 
                          ReportStates.Solucionado].map((e) => DropdownMenuItem(child: Text(e.toString().split('.').last), value: e,)).toList(),
                          onChanged: (value) {
                            setState(() {
                              _toState = value as ReportStates;
                              con.changeState(reporte.id, _toState,widget.desc.text);
                            });
                          },
                        ),
                        Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: TextField(
                  controller: widget.desc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.comment_rounded,
                      color: Colors.black,
                    ),
                    labelText: 'Comentario',
                  ),
                ),
            ),
                      ],
                ),
              ),
            ),
            Center(
              child: Text(
                "Historial de estados",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (ReportState state in reporte.reportState)
                  Card(
                    //sombra de la tarjeta mas oscura
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(getStateIcon(state.state),
                                    color: Colors.black)
                              ]),
                          title: Text(
                              "${state.state.toString().split('.').last} - ${state.createdAt.toString().substring(0, 10)} ${state.createdAt.toString().substring(11, 16)}"),
                        ),
                        ListTile(
                          title: Text("Comentario"),
                          subtitle: Text(state.comment),
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
    case ReportStates.Publicado:
      return Icons.publish;
    case ReportStates.Pendiente:
      return Icons.access_time_outlined;
    case ReportStates.Revision:
      return Icons.remove_red_eye_outlined;
    case ReportStates.Rechazado:
      return Icons.cancel_outlined;
    case ReportStates.Solucionado:
      return Icons.check_circle_outline;
    default:
      return Icons.abc;
  }
}
