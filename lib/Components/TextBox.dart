

import 'package:flutter/material.dart';


class TextBox extends StatelessWidget {

  String placeholder=" ";

  var getValue;

  
  TextBox({
   
   required this.placeholder,
   required this.getValue
  
    
  });

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 240, 238, 238),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(onChanged: (value){getValue(value);},decoration: InputDecoration(border: InputBorder.none,hintText:placeholder),),
        ));
  }
}
