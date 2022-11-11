import 'dart:async';
import 'dart:developer';

import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logo extends StatefulWidget {
  logo({Key? key}) : super(key: key);

  @override
  State<logo> createState() => _logoState();
}

class _logoState extends State<logo> {


  @override
  Widget build(BuildContext context) {
    Timer _continue = Timer(const Duration(milliseconds: 1000), () async {
      UserController user = Get.find<UserController>();
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('jwt');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                jwt != null ? const HomePage() : const Login(),
          ));
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.jpg',
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text(
                'Bienvenido a GlApp',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
