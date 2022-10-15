import 'package:f_shopping_app/ui/controller/PurchaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PurchaseController con = Get.find<PurchaseController>();
    return Expanded(
      child: Center(
        child: Obx(() => Text('Total: ${con.total} usd',
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400))),
      ),
    );
  }
}
