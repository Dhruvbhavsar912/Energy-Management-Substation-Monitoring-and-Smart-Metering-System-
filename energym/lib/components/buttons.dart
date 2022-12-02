import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {

  Roundedbutton({this.colour,this.txt,@required this.onpress});

  final Color colour;
  final String txt;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            txt,
            style: TextStyle(
              color:Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
