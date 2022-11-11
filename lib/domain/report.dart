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
  ReportStates state;
  String idUsuario;
  List reportState = <ReportState>[];

  Report(this.id, this.location, this.bitmap, this.title, this.desc, this.date,
      this.state, this.idUsuario, this.reportState);

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
      ReportStates.values[json['state']],
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
    this.state = state;
  }
}
