import 'package:f_shopping_app/ui/pages/login.dart';
import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  const logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
              },
              child: const Text('Bienvenido a GlApp continuar ->',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
            
          ],
        ),
      ),
    );
  }
}