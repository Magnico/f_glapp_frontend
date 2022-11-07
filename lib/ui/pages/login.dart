import 'package:f_shopping_app/ui/Widgets/button.dart';
import 'package:f_shopping_app/ui/pages/home_page.dart';
import 'package:f_shopping_app/ui/pages/sign_up.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Login_Form createState() => Login_Form();
}

class Login_Form extends State<Login> {
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
            children: const <Widget>[
              Expanded(
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
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
            children: const <Widget>[
              Expanded(
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '*********',
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
        BTNavigation(MediaQuery.of(context).size.width, const HomePage(),"Login", this),
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
        BTNavigation(MediaQuery.of(context).size.width, const SignUp(),"Sign Up", this),
      ]),
    );
  }
}
