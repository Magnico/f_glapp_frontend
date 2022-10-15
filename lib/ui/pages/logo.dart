import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  const logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.jpg',
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to the GlApp',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}