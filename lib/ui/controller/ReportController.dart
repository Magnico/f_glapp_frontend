import 'package:f_shopping_app/domain/report.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportController extends GetxController {
  LatLng _currentLocation = LatLng(0, 0);
  var _reports = [].obs;
  var _amount = [0,0,0];
  get reportes => _reports.value;
  get currentLocation => _currentLocation;
  String get currentLocationString => _currentLocation.toString();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addReport(0, "Gas", LatLng(10.988829, -74.81239219999999), "nosé", DateTime.now());
    addReport(1, "Agua", LatLng(10.9872183, -74.8126964), "nise", DateTime.now());
  }

  //cambiar ubicacion actual
  void changeLocation(LatLng location) {
    _currentLocation = location;
    update();
  }
  //get currentlocation in string
  
  void addReport(int type, String title, LatLng location, String desc, DateTime date) {
    _reports.add(Report(_reports.length.toString(),location,type,title,desc,date));
    _amount[type]++;
    update();
  }
  
}