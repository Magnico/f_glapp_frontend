import 'dart:convert';
import 'dart:developer';

import 'package:f_shopping_app/domain/report.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';

class ReportController extends GetxController {
  LatLng _currentLocation = LatLng(0, 0);
  var _reports = <Report>[].obs;
  var _amount = [1, 1, 1];
  var allMakers = <Marker>[].obs;
  get reportes => _reports;
  get currentLocation => _currentLocation;
  String get currentLocationString => _currentLocation.toString();
  void onInit() {
    super.onInit();
    /* _reports.add(Report("Agua", -74.866522, 11.023077, 0,'Corte de Agua'));
    _reports.add(Report("Luz", -74.867867, 11.023156, 1,'Corte de Luz'));
    _reports.add(Report("Gas", -74.868608, 11.021775, 2,'Corte de Gas')); */

    fetchReports();
  }

  fetchReports() async {
    final url = Uri.parse(Config.API_URL + "/reports");

    final sharedPrefs = await SharedPreferences.getInstance();

    final token = sharedPrefs.getString("jwt");

    log(token!);
    // sharedPrefs.remove("jwt");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    };

    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      var reports = <Report>[];

      json.forEach((report) {
        reports.add(Report.fromJson(report));
      });

      _reports = reports.obs;
      _reports.refresh();
      log('reportes guardados');
    } else {
      log(response.body.toString());
    }
  }

  //cambiar ubicacion actual
  void changeLocation(LatLng location) {
    _currentLocation = location;
    update();
  }
  //get currentlocation in string

  void addReport(int type, String name, double lat, double lng) {
    /*  switch (type) {
      case 0:
        _reports.add(Report(
            "Agua" + lat.toString() + lng.toString(), lng, lat, 0, name));
        break;
      case 1:
        _reports.add(
            Report("Luz" + lat.toString() + lng.toString(), lng, lat, 1, name));
        break;
      case 2:
        _reports.add(
            Report("Gas" + lat.toString() + lng.toString(), lng, lat, 2, name));
        break;
      default:
    } */
  }

  String giveName(int type) {
    _amount[type] += 1;
    switch (type) {
      case 0:
        return 'Corte de Agua #' + _amount[type].toString();
      case 1:
        return 'Corte de Luz #' + _amount[type].toString();
      case 2:
        return 'Corte de Gas #' + _amount[type].toString();
    }
    return '';
  }
}
