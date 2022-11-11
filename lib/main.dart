import 'package:f_shopping_app/ui/app.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/controller/providerController.dart';
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
  Get.lazyPut<ReportController>(() => ReportController());
  Get.lazyPut<ProviderController>(() => ProviderController());
  runApp(MyApp());
}
