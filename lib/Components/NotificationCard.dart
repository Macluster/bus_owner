


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
      margin: EdgeInsets.only(bottom: 5),
      width: double.infinity,
      height: 100,
      decoration:const BoxDecoration(
        
         gradient: SweepGradient(
          colors: [ Color(0xff9796F0),
        Color(0xffFBC7D4),],
          stops: [0, 1],
          center: Alignment.topLeft,
        ),
        
        color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(10))),
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