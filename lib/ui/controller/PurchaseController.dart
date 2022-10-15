import 'package:f_shopping_app/domain/product.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  var _product = [].obs;
  var _total = 0.0.obs;

  get total => _total.value;
  get items => _product.value;

  void onInit() {
    super.onInit();
    _product.add(Product(0, "Toy car", 10));
    _product.add(Product(1, "Toy house", 20));
  }

  void addProduct(int id) {
    _product.firstWhere((element) => element.id == id).quantity++;
    _product.refresh();
    onTotalBuy();
  }

  void deleteProduct(int id) {
    if(_product.firstWhere((element) => element.id == id).quantity > 0){
      _product.firstWhere((element) => element.id == id).quantity--;
    }else{
      _product.firstWhere((element) => element.id == id).quantity = 0;
    }
    _product.refresh();
    onTotalBuy();
  }

  int getQuantity(int id){
     return _product.firstWhere((element) => element.id == id).quantity;
  }
  void onTotalBuy(){ 
    _total.value = _product.fold(0, (sum, element) => sum + element.quantity * element.price);
  }
}