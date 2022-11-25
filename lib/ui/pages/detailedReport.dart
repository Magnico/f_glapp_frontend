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
  int actual = 2;
  final FocusNode myFocusNode = FocusNode();
  late ReportStates _toState = ReportStates.values[widget.reporte.state.index];

  var stados = [
    ReportStates.Publicado,
    ReportStates.Revision,
    ReportStates.Rechazado,
    ReportStates.Solucionado
  ]
      .map((e) => DropdownMenuItem(
            child: Text(e.toString().split('.').last),
            value: e,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    ReportController con = Get.find<ReportController>();
    UserController user = Get.find<UserController>();
    var reporte = widget.reporte;
    bool _isEnterprise = user.role == 0;
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
                  subtitle: Text(reporte.state.name),
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
                child: Column(
                  children: [
                    Icon(
                      Icons.change_circle_rounded,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      items: stados,
                      value: _toState,
                      onChanged: (value) {
                        setState(() {
                          _toState = value as ReportStates;
                        });
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
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
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0, bottom: 50),
                      child: ElevatedButton(
                        child: const Text("Guardar",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        onPressed: () async {
                          con.updateState(
                              reporte.id, widget.desc.text, _toState);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                      ),
                    )
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
