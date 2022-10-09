import 'package:flutter/material.dart';

import '../const.dart';

class MyButton extends StatelessWidget {
  final String sufi;
  final VoidCallback onTap;
  var buttonColor = Colors.deepPurple[400];

  MyButton({Key? key, required this.sufi, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sufi == 'AC') {
      buttonColor = Colors.green;
    } else if (sufi == 'DEL') {
      buttonColor = Colors.red;
    } else if (sufi == '=') {
      buttonColor = Colors.deepPurple;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              sufi,
              style: whiteTextStyle,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
