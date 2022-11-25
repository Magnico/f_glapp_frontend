import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class BTNavigation extends StatelessWidget {
  BTNavigation(this.parentWidth, this.destination, this.text, this.reference,
      this.callback,
      {Key? key})
      : super(key: key);
  var destination;
  var parentWidth;
  var reference;
  final String text;
  Function()? callback;

  //Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: parentWidth,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Color.fromARGB(255, 81, 204, 184),
              ),
              onPressed: () {
                callback != null
                    ? callback!()
                    : Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => destination),
                      );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 50.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
