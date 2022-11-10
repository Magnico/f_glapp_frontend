import 'dart:developer';

import 'package:f_shopping_app/ui/Widgets/button.dart';
import 'package:f_shopping_app/ui/Widgets/passwordField.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../config/config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Login_Form createState() => Login_Form();
}

class Login_Form extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  handleLogin() async {
    // url base de la api
    // final API_URL = "https://glapp-api.herokuapp.com";
    // url de la api para el login
    final url = Uri.parse(Config.API_URL + "/auth/signin");

    // datos del formulario
    final data = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      // respuesta de la ap
      final response = await post(url, body: data);

      // si la respuesta es 200 (ok)
      if (response.statusCode == 200) {
        // ToDO guardar jwt en shared preferences

        // redireccionar a la pagina de inicio
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error, Credenciales incorrectas'),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(children: [
        //Icon profile 300x300 px
        const Icon(
          Icons.account_circle,
          size: 200,
          color: Colors.blue,
        ),
        const SizedBox(),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "EMAIL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 82, 122, 255),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 82, 122, 255),
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: emailController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'glapp@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 24.0,
        ),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 82, 125, 255),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 82, 131, 255),
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[PasswordField(passwordController)],
          ),
        ),
        const Divider(
          height: 24.0,
        ),
        BTNavigation(MediaQuery.of(context).size.width, const HomePage(),
            "Login", this, handleLogin),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
              const Text(
                "OR ",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
            ],
          ),
        ),
        BTNavigation(MediaQuery.of(context).size.width, const SignUp(),
            "Sign Up", this, null),
      ]),
    );
  }
}
