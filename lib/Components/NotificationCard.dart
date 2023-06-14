


import 'package:bus_owner/Model/BusModel.dart';
import 'package:bus_owner/Model/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationCard extends StatelessWidget
{

  NotificationModel model;
 NotificationCard(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 100,
      decoration:const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 50,color: Color.fromARGB(255, 207, 205, 205),spreadRadius: 1)],
        
        color: Color.fromARGB(255, 241, 243, 243),borderRadius: BorderRadius.all(Radius.circular(10))),
      child:Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(model.Who,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(model.Content,style: TextStyle(fontSize: 15))
         
        ],),
      ) ,
    );
  }

}