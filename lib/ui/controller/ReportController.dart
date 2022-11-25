import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:f_shopping_app/domain/report.dart';
import 'package:f_shopping_app/domain/states.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/detailedReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List serviceIcons = [
    SvgPicture.asset('images/gasIcon.svg'),
    SvgPicture.asset('images/waterIcon.svg'),
    SvgPicture.asset('images/energyIcon.svg'),
  ];

  String get currentLocationString => _currentLocation.toString();

  @override
  void onInit() {
    super.onInit();
    loadReportsIcons();
    fetchReports();
  }

  void loadReportsIcons() async {
    const size = Size(40, 40);

    IconSet[0] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: size), 'images/gas.png');
    IconSet[1] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: size), 'images/water.png');
    IconSet[2] = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: size), 'images/energy.png');
  }

  void changeState(String id, ReportStates state, String comment) async {
    final report = _reports.firstWhere((element) => element.id == id);
    report.changeStatus(state, comment);
    update();
  }

  fetchReports() async {
    UserController user = Get.find<UserController>();

    var endpoint = '/reports';

    if (user.role == 0) {
      endpoint = "/reports/provider/${user.id}";
    }
    final url = Uri.parse(Config.API_URL + endpoint);

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

      allMakers.clear();
      reports.clear();

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
              snippet: report.state.name,
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
      update();
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
      'title': title,
      'description': desc,
      'createdAt': date.toString()
    };

    final response = await post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      await fetchReports();
      _reports.refresh();
    } else {
      log(response.body.toString());
    }
    update();
  }

  delteReport(String id) async {
    final url = Uri.parse(Config.API_URL + "/reports/$id");

    UserController userController = Get.find<UserController>();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + userController.jwt!
    };

    final response = await delete(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      _reports.removeWhere((element) => element.id == id);
      allMakers.removeWhere((element) => element.markerId.value == id);
      _reports.refresh();
      log('reporte eliminado');
    } else {
      log(response.body.toString());
    }
  }

  updateState(String report, String comment, ReportStates state) async {
    final url = Uri.parse(Config.API_URL + "/reports/$report/state");

    UserController userController = Get.find<UserController>();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + userController.jwt!
    };

    final data = {
      'provider': userController.id,
      'report': report,
      'state': state.index,
      'comment': comment,
    };

    final response = await post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      fetchReports();
    } else {
      log(response.body.toString());
    }
  }

  SvgPicture getIcon(int bitmap) {
    return serviceIcons[bitmap];
  }

  getReports() {
    UserController user = Get.find<UserController>();

    if (user.role == 0) {
      return _reports;
    } else {
      return _reports.where((element) => element.idUsuario == user.id).toList();
    }
  }
}
