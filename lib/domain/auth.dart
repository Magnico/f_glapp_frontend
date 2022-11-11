import 'dart:convert';

import 'package:f_shopping_app/domain/user.dart';
import 'package:flutter/foundation.dart';

class Auth {
  final String jwt;
  final User user;
  // Todo - add more user fields

  const Auth({
    required this.jwt,
    required this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    final userData = json['result'];

    return Auth(
        jwt: json['token'],
        user: User(
            email: userData['email'],
            name: userData['name'],
            identification_number: userData['identification_number'],
            role: userData['role'],
            id: userData['_id']));
  }
}
