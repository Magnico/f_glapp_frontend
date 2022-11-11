import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../domain/user.dart';

class ProviderController extends GetxController {
  final _providers = <User>[].obs;

  get providers => _providers;

  fetchProviders() async {
    final url = Uri.parse(Config.API_URL + "/providers");

    final sharedPrefs = await SharedPreferences.getInstance();

    final token = sharedPrefs.getString("jwt");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token!
    };

    final response = await get(url, headers: headers);

    for (var provider in jsonDecode(response.body)) {
      _providers.add(User.fromJson(provider));
    }
  }

  getProviderList() {
    final List<Map<String, dynamic>> _empresas = [];

    int index = 0;

    for (User p in _providers) {
      _empresas.add({'value': index.toString(), 'label': p.name});

      index++;
    }

    return _empresas;
  }
}
