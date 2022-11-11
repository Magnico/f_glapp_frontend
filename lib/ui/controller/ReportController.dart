import 'dart:convert';
import 'dart:developer';

import 'package:f_shopping_app/domain/report.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/detailedReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../domain/user.dart';

class ReportController extends GetxController {
  LatLng _currentLocation = LatLng(0, 0);

  var _reports = <Report>[].obs;
  var allMakers = <Marker>[].obs;
  
  get reportes => _reports;
  get currentLocation => _currentLocation;

  List<BitmapDescriptor> IconSet = [
    BitmapDescriptor.defaultMarker,
    BitmapDescriptor.defaultMarker,
    BitmapDescriptor.defaultMarker
  ];
  List<IconData> serviceIcons = [
    Icons.gas_meter_rounded,
    Icons.water_drop,
    Icons.lightbulb,
  ];

  String get currentLocationString => _currentLocation.toString();

  @override
  void onInit() {
    super.onInit();
    loadReportsIcons();
    fetchReports();
  }

  void loadReportsIcons() async {
    IconSet[0] =//GAS
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    IconSet[1] =//LUZ
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    IconSet[2] =//AGUA
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
  }

  fetchReports() async {
    final url = Uri.parse(Config.API_URL + "/reports");

    final sharedPrefs = await SharedPreferences.getInstance();

    final token = sharedPrefs.getString("jwt");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token!
    };

    final response = await get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

      var reports = <Report>[];

      json.forEach((r) {
        Report report = Report.fromJson(r);

        reports.add(report);
        allMakers.add(
          Marker(
            draggable: false,
            markerId: MarkerId(report.id),
            position: report.location,
            icon: IconSet[report.bitmap],
            infoWindow: InfoWindow(
              title: report.title,
              snippet: report.state.toString().split('.').last,
              onTap: () {
                Navigator.push(
                  Get.context!,
                  MaterialPageRoute(
                    builder: (context) => DetailReportPage(report),
                  ));
              },
            ),
          ),
        );
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

  void addReport(String provider, String title, LatLng location, String desc,
      DateTime date) async {
    final url = Uri.parse(Config.API_URL + "/reports");

    final sharedPrefs = await SharedPreferences.getInstance();
    final token = sharedPrefs.getString("jwt");
    final User user = User.fromJson(jsonDecode(sharedPrefs.getString("user")!));

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token!
    };

    // datos del formulario
    final data = {
      'user': user.id,
      'provider': provider,
      'lat': location.latitude,
      'lng': location.longitude,
      'description': desc,
      'createdAt': date.toString()
    };

    final response = await post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      Report report = Report.fromJson(json);

      _reports.add(report);
      allMakers.add(
        Marker(
          draggable: false,
          markerId: MarkerId(report.id),
          position: report.location,
          icon: IconSet[report.bitmap],
          infoWindow: InfoWindow(
            title: report.title,
            snippet: report.state.toString().split('.').last,
            onTap: () => log(report.location.toString()),
          ),
        ),
      );
      _reports.refresh();
      log('reporte guardado');
    } else {
      log(response.body.toString());
    }
    update();
  }

  IconData getIcon(int bitmap) {
    return serviceIcons[bitmap];
  }
  
}
