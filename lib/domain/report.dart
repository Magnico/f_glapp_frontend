import 'dart:developer';

import 'package:f_shopping_app/domain/reportState.dart';
import 'package:f_shopping_app/domain/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Report {
  String id;
  DateTime date;
  LatLng location;
  int bitmap;
  String title;
  String desc;
  ReportStates? state;
  String idUsuario;
  List history = [];
  List reportState = <ReportState>[];

  Report(this.id, this.location, this.bitmap, this.title, this.desc, this.date,
      this.idUsuario, this.reportState) {
    history.add({
      "state": ReportStates.Publicado,
      "eventDate": date,
      "comment": "Reporte creado"
    });
    history.add({
      "state": ReportStates.Pendiente,
      "eventDate": DateTime.now(),
      "comment": "Reporte creado\nEn espera de ser revisado"
    });
    history.add({
      "state": ReportStates.Revision,
      "eventDate": DateTime.now(),
      "comment":
          "Reporte creado\nEn espera de ser revisado\nEn espera de ser solucionado"
    });
    history.add({
      "state": ReportStates.Rechazado,
      "eventDate": DateTime.now(),
      "comment": "Reporte creado"
    });
    state = ReportStates.Solucionado;
    log("Reporte creado");
    log(history.toString());
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    var states = json['states'] as List;

    for (var i = 0; i < states.length; i++) {
      states[i] = ReportState.fromJson(states[i]);
    }

    return Report(
      json['_id'],
      LatLng(json['lat'], json['lng']),
      json['type'],
      json['title'],
      json['description'],
      DateTime.parse(json['createdAt']),
      json['user'],
      states,
    );
  }

  void changeStatus(ReportStates state, String comment) {
    var package = {
      "state": state,
      "eventDate": DateTime.now(),
      "comment": comment
    };
    history.add(package);
    this.state = state;
  }
}
