import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(this.textController, this.hintText, {Key? key}) : super(key: key);

  TextEditingController textController;
  String hintText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
            color: const Color(0xFFB3B3B3),
            width: 1.0,
            style: BorderStyle.solid),
      ),
      padding: const EdgeInsets.only(left: 10.0, right: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
