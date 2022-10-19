import 'package:f_shopping_app/domain/report.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  var _reports = [].obs;
  var _total = 0.0.obs;

  get total => _total.value;
  get reportes => _reports.value;

  void onInit() {
    super.onInit();
    _reports.add(Report("Agua",11.023077, -74.866522, 0));
    _reports.add(Report("Luz", 11.023156, -74.867867, 1));
    _reports.add(Report("Gas", 11.021775, -74.868608, 2));
  }

  void addProduct(int id) {
    
  }

  void deleteProduct(int id) {
    
  }

  int getQuantity(int id){
    return 0;
  }
  void onTotalBuy(){ 
    
  }
}