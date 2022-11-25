import 'dart:convert';
import 'dart:developer';

import 'package:f_shopping_app/domain/auth.dart';
import 'package:f_shopping_app/ui/Widgets/button.dart';
import 'package:f_shopping_app/ui/Widgets/passwordField.dart';
import 'package:f_shopping_app/ui/Widgets/textInput.dart';
import 'package:f_shopping_app/ui/controller/ReportController.dart';
import 'package:f_shopping_app/ui/controller/UserController.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        final sharedPref = await SharedPreferences.getInstance();

        final json = jsonDecode(response.body);

        final auth = Auth.fromJson(json);

        sharedPref.setString("jwt", auth.jwt);
        sharedPref.setString("user", jsonEncode(auth.user));

        UserController user = Get.find<UserController>();
        user.getUser();
        ReportController report = Get.find<ReportController>();
        report.fetchReports();

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
        SizedBox(
          height: 30,
        ),
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
                padding: EdgeInsets.only(left: 40.0, top: 40),
                child: Text(
                  "Correo electronico",
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
        TextInput(emailController, "user@glap.com"),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "Contraseña",
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
          margin: const EdgeInsets.only(
              left: 40.0, right: 40.0, top: 10.0, bottom: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: const Color(0xFFB3B3B3),
                width: 1.0,
                style: BorderStyle.solid),
          ),
          padding: const EdgeInsets.only(left: 10.0, right: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[PasswordField(passwordController)],
          ),
        ),
        BTNavigation(MediaQuery.of(context).size.width, const HomePage(),
            "Ingresar", this, handleLogin),
        BTNavigation(MediaQuery.of(context).size.width, const SignUp(),
            "Registrarse", this, null),
      ]),
    );
  }
}
