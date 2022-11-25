import 'dart:convert';

import 'package:f_shopping_app/ui/Widgets/button.dart';
import 'package:f_shopping_app/ui/Widgets/passwordField.dart';
import 'package:f_shopping_app/ui/Widgets/textInput.dart';
import 'package:f_shopping_app/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import 'home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUp_Form();
}

class SignUp_Form extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final idController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final numController = TextEditingController();

    handleSignup() async {
      // url base de la api
      // final API_URL = "https://glapp-api.herokuapp.com";

      // url de la api para el login
      final url = Uri.parse(Config.API_URL + "/auth/signup");

      // datos del formulario
      final data = {
        "email": emailController.text,
        "password": passwordController.text,
        "name": nameController.text,
        "identification_number": idController.text,
        "role": 1,
        "number": numController.text,
      };

      // respuesta de la api
      final response = await post(url, body: jsonEncode(data));

      // si la respuesta es 200 (ok)
      if (response.statusCode == 200) {
        final sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString("jwt", response.body);

        // redireccionar a la pagina de inicio
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error, con el servidor'),
          ),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(children: [
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
                  "Nombre",
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
          margin:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextInput(nameController, "Ingresa tu nombre completo"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "Identificación",
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
          margin:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextInput(idController, "Ingresa tu identificación"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "Telefono",
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
          margin:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:
                    TextInput(numController, "Ingresa tu número de telefono"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "Correo Electronico",
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
          margin:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 5),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextInput(emailController, "Ingresa tu email"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: const <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  "Contraseña",
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
          margin:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 0),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: PasswordField(passwordController),
              ),
            ],
          ),
        ),
        BTNavigation(MediaQuery.of(context).size.width, const Login(),
            "Guardar", this, handleSignup),
        const SizedBox(
          height: 40.0,
        ),
      ]),
    );
  }
}
