import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/user.dart';

class UserController extends GetxController {
  // string observable variable
  final _name = "".obs;
  final _email = "".obs;
  final _identificationNumber = "".obs;
  final _id = "".obs;
  final _jwt = "".obs;
  final _role = 0.obs;

  get name => _name.value;
  get email => _email.value;
  get identificationNumber => _identificationNumber.value;
  get id => _id.value;
  get jwt => _jwt.value;
  get role => _role.value;

  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    final jwt = prefs.getString('jwt');

    if (userJson != null) {
      final user = User.fromJson(jsonDecode(userJson));

      _name.value = user.name;
      _email.value = user.email;
      _identificationNumber.value = user.identification_number;
      _id.value = user.id;
      _jwt.value = jwt!;
      _role.value = user.role;
    }
  }
}
