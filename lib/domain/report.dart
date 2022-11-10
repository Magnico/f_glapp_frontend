import 'dart:developer';

import 'package:f_shopping_app/domain/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Report {
  String id;
  DateTime date;
  LatLng location;
  int bitmap;
  String title;
  String desc;
  ReportState? state;
  List history = [];

  Report(this.id, this.location, this.bitmap, this.title, this.desc, this.date){
    history.add({"state":ReportState.Publicado,"eventDate":date,"comment":"Reporte creado"});
    state = ReportState.Publicado;
    log("Reporte creado");
    log(history.toString());
  }
  
  void changeStatus(ReportState state, String comment){
    var package = {"state": state,"eventDate": DateTime.now(), "comment": comment};
    history.add(package);
    this.state = state;
  }
}
