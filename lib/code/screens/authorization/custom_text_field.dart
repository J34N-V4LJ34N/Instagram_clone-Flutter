import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeHolderText;

  const CustomTextField({
    Key? key,
    required this.placeHolderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: placeHolderText,
          // labelStyle: TextStyle(color: Colors.grey[400]),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey, width: 0.0),
          // ),
          // isDense: true,
          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        ),
      ),
    );
  }
}
