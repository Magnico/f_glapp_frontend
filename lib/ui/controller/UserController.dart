import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/user.dart';

class UserController extends GetxController {
  // string observable variable
  var _name = "".obs;
  var _email = "".obs;
  var _identificationNumber = "".obs;

  get name => _name.value;
  get email => _email.value;
  get identificationNumber => _identificationNumber.value;

  @override
  void onInit() {
    // TODO: implement onInit
    SharedPreferences.getInstance().then((prefs) {
      final userJson = prefs.getString('user');

      if (userJson != null) {
        final user = User.fromJson(jsonDecode(userJson));

        _name.value = user.name;
        _email.value = user.email;
        _identificationNumber.value = user.identificationNumber;
      }
    });

    super.onInit();
  }
}
