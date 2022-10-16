import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);
  
  @override
  State<Report> createState() => Report_Form();
  
}

class Report_Form extends State<Report> {
    @override
  Widget build(BuildContext context) {
    return new Scaffold(body:  Column(
      children: [
        Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdsjmuyYJ317XWzd-JHsHZyAzOhBAP7LBvZw&usqp=CAU", height: 300,width: 300,),
      ]
    ),

    );
  }

}