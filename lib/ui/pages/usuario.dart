import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  const Usuario({Key? key}) : super(key: key);
  
  @override
  State<Usuario> createState() => Usuario_Form();
  
}

class Usuario_Form extends State<Usuario> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Column(
      children: [
        Image.network("https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.vecteezy.com%2Farte-vectorial%2F5005835-icono-de-usuario-en-estilo-plano-de-moda-aislado-sobre-fondo-gris-simbolo-de-usuario-para-el-diseno-de-su-sitio-web-logo-app-ui-vector-illustration-eps10&psig=AOvVaw0gg_m6Z0XRPrlavlBSqZ6G&ust=1666048496530000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCPjctrrw5foCFQAAAAAdAAAAABAS", height: 300,width: 300,),
      ]
    ),

    );
  }

}