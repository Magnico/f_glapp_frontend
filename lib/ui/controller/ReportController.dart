import 'package:f_shopping_app/domain/report.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  var _reports = [].obs;
  var _amount = [1,1,1];
  get reportes => _reports.value;

  void onInit() {
    super.onInit();
    _reports.add(Report("Agua", -74.866522, 11.023077, 0,'Corte de Agua'));
    _reports.add(Report("Luz", -74.867867, 11.023156, 1,'Corte de Luz'));
    _reports.add(Report("Gas", -74.868608, 11.021775, 2,'Corte de Gas'));
  }
  void addReport(int type, String name, double lat, double lng){
    switch (type) {
      case 0:
        _reports.add(Report("Agua"+lat.toString()+lng.toString(), lng, lat, 0,name));
        break;
      case 1:
        _reports.add(Report("Luz"+lat.toString()+lng.toString(), lng, lat, 1,name));
        break;
      case 2:
        _reports.add(Report("Gas"+lat.toString()+lng.toString(), lng, lat, 2,name));
        break;
      default:
    }
  }

  String giveName(int type){
    _amount[type]+=1;
    switch (type) {
      case 0:
        return 'Corte de Agua #'+_amount[type].toString();
      case 1:
        return 'Corte de Luz #'+_amount[type].toString();
      case 2:
        return 'Corte de Gas #'+_amount[type].toString();
    }
    return '';
  }
}