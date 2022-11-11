import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../domain/user.dart';

class ProviderController extends GetxController {
  final _providers = <User>[].obs;

  final providersList = [].obs;
  RxList<User> get providers => _providers;

  @override
  onInit() {
    super.onInit();
    providersList.add(item('', ''));

    fetchProviders();
  }

  fetchProviders() async {
    final url = Uri.parse(Config.API_URL + "/providers");

    final sharedPrefs = await SharedPreferences.getInstance();

    final token = sharedPrefs.getString("jwt");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token!
    };

    final response = await get(url, headers: headers);

    int index = 0;
    providersList.clear();
    for (var provider in jsonDecode(response.body)) {
      var p = User.fromJson(provider);
      _providers.add(p);
      providersList.add(item(p.name, index.toString()));

      index++;
    }
  }
}

class item {
  String label;
  String value;

  item(this.label, this.value);
}
