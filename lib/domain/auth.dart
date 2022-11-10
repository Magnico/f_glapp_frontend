import 'package:flutter/foundation.dart';

class Auth {
  final String jwt;
  // Todo - add more user fields

  const Auth({
    required this.jwt,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      jwt: json['token'],
    );
  }
}
