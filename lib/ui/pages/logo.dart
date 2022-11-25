import 'dart:async';
import 'dart:developer';

import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer _continue = Timer(const Duration(milliseconds: 1000), () async {
      UserController controller = Get.find<UserController>();
      controller.getUser();

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                controller.jwt != null ? const HomePage() : const Login(),
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
                ' ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 88, 154, 220),
    );
  }
}
