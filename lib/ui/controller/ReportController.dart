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
  var allMakers = <Marker>[].obs;
  var _amount = [0,0,0];
 
  get reportes => _reports.value;
  get currentLocation => _currentLocation;
  String get currentLocationString => _currentLocation.toString();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchReports();
    /*addReport(0, "Gas", LatLng(10.988829, -74.81239219999999), "nosé", DateTime.now());
    addReport(1, "Agua", LatLng(10.9872183, -74.8126964), "nise", DateTime.now());*/
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
  
  void addReport(int type, String title, LatLng location, String desc, DateTime date) {
    _reports.add(Report(_reports.length.toString(),location,type,title,desc,date));
    _amount[type]++;
    update();
  }
  
}
