import 'package:f_shopping_app/ui/app.dart';
import 'package:f_shopping_app/ui/controller/PurchaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  Get.lazyPut<PurchaseController>(() => PurchaseController());
  runApp(MyApp());
}
