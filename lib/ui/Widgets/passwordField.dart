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
    return Expanded(
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
    );
  }
}
