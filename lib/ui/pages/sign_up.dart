import 'package:f_shopping_app/ui/pages/login.dart';
import 'package:flutter/material.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  
  @override
  State<SignUp> createState() => SignUp_Form();
  
}

class SignUp_Form extends State<SignUp> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Column(
      children: [
        Image.network("https://media.istockphoto.com/vectors/sign-up-icon-isolated-on-white-background-vector-illustration-vector-id1193039142?k=20&m=1193039142&s=612x612&w=0&h=e53ulqLdsZowR7K4kuoI8OoVwi8IbPff1CKHKNPmGBw=", height: 300,width: 300,),
        const SizedBox(
          
          
        ),
        

          Row(
            children: const <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    "NAME",
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
                    
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ingresa tu nombre completo',
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
                    "IDENTIFICACIÓN",
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
                    keyboardType: TextInputType.number,
                    
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ingresa el numero de identificación ',
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
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ingresa tu correo electronico',
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
                    "CONTRASEÑA",
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
                    keyboardType: TextInputType.visiblePassword,
                    
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'crea una nueva contraseña',
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
                    "ROLE",
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
                    keyboardType: TextInputType.visiblePassword,
                    
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ingrese rol "Usuario" o "Empresa"',
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
          
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color.fromARGB(255, 82, 125, 255),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Expanded(
                            child: Text(
                              "SAVE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          


      ]

    ),
    
    );

  }
}