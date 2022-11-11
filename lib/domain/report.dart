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
  String idUsuario;
  List history = [];

  Report(
      this.id, this.location, this.bitmap, this.title, this.desc, this.date, this.idUsuario) {
    history.add({
      "state": ReportState.Publicado,
      "eventDate": date,
      "comment": "Reporte creado"
    });
    history.add({
      "state": ReportState.Pendiente,
      "eventDate": DateTime.now(),
      "comment": "Reporte creado\nEn espera de ser revisado"
    });
    history.add({
      "state": ReportState.Revision,
      "eventDate": DateTime.now(),
      "comment": "Reporte creado\nEn espera de ser revisado\nEn espera de ser solucionado"
    });
    history.add({
      "state": ReportState.Rechazado,
      "eventDate": DateTime.now(),
      "comment": "Reporte creado"
    });
    state = ReportState.Solucionado;
    log("Reporte creado");
    log(history.toString());
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Report(
      json['_id'],
      LatLng(json['lat'], json['lng']),
      0,
      json['description'],
      json['description'],
      DateTime.parse(json['createdAt']),
      json['user'],
    );
  }

  void changeStatus(ReportState state, String comment) {
    var package= {
      "state": state,
      "eventDate": DateTime.now(),
      "comment": comment
    };
    history.add(package);
    this.state = state;
  }
}
