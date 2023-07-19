
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget
{
  String content="";
  var  ontap;
  Button1(this.content,this.ontap);
 
  @override
  Widget build(BuildContext context) {

      return   GestureDetector(
                          onTap: (){
                            ontap();
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.amber,),
                            alignment: Alignment.center,
                            height: 60,
                            width: double.infinity,
                         
                            child: Text(content),
                          ),
                        );
  }

}