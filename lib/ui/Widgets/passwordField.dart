// create flutter widget

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  PasswordField(this.passwordController, {Key? key}) : super(key: key);

  TextEditingController passwordController;
  bool visible = false;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin:
          const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 20),
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
        children: <Widget>[
          Expanded(
            child: TextField(
              obscureText: !widget.visible,
              controller: widget.passwordController,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Ingresa tu contraseña',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: InkWell(
                  onTap: () => setState(() => {
                        widget.visible = !widget.visible,
                      }),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    !widget.visible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
