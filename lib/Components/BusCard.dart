


import 'package:bus_owner/Model/BusModel.dart';
import 'package:bus_owner/Screens/BusInformationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BusCard extends StatelessWidget
{

  BusModel model;
  BusCard(this.model);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BusInformationPage(model)));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        
        decoration:const BoxDecoration(  gradient: SweepGradient(
            colors: [ Color(0xff9796F0),
          Color(0xffFBC7D4),],
            stops: [0, 1],
            center: Alignment.topLeft,
          ),color: Colors.amber,borderRadius: BorderRadius.all(Radius.circular(10))),
        child:Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(model.busName+" Bus",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 5,),
            Row(children: [Icon(Icons.location_on),Text(model.busCurrentLocation,style: TextStyle(fontSize: 15))],)
          ],),
        ) ,
      ),
    );
  }

}