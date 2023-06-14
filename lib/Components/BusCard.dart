


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
        margin: EdgeInsets.only(bottom: 15),
        
        decoration:BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 50,color: Color.fromARGB(255, 214, 213, 213),spreadRadius: 1)],
        
        color: Color.fromARGB(255, 241, 243, 243),borderRadius: BorderRadius.all(Radius.circular(10))),
        child:Padding(
          padding: const EdgeInsets.all(17),
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