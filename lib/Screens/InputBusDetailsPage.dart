import 'package:bus_owner/Backend/SupabaseDatabase.dart';
import 'package:bus_owner/Components/TextBox.dart';
import 'package:bus_owner/Model/BusModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Backend/FireBaseDatabase.dart';
import '../Backend/data.dart';
import '../Components/DropDownList.dart';

class InputBusDetailsPage extends StatefulWidget {

  @override
  State<InputBusDetailsPage> createState() => _InputBusDetailsPageState();
}

class _InputBusDetailsPageState extends State<InputBusDetailsPage> {
  String busName="";
  String busNumber="";
  String destinationStop="";
  String startingStop="";
  String StartTime="";
  int routeIndex=0;

  
  Future<void> getRoute() async {
    var routes = await FirebaseDatabaseClass()
        .gerRouteIdAndBusStops(startingStop, destinationStop);

  

    setState(() {
    
      routeIndex = routes['routeIndex'];
      print( routes['routeIndex']);
    });
  }

  int getStopId(String stop)
  {
    int id=0;
    bustops.forEach((element) {
      if(element['name']==stop)
      {
        id=element['id'] as int;
      }
    });

    return id;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  Theme.of(context).primaryColorLight,
        foregroundColor: Colors.black,
        leading: Icon(Icons.arrow_back),
        title: Text("Input Bus Details"),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextBox(placeholder: "Bus Name",getValue: (value){setState(() {
                busName=value;
              });},),
                  TextBox(placeholder: "Bus Number",getValue: (value){setState(() {
                busNumber=value;
              });},),
               
                TextBox(placeholder: "Start Time",getValue: (value){setState(() {
                StartTime=value;
              });},),
                DropDownList(bustops, startingStop, "Starting Bus stop",
                    (e) async {
                  setState(() {
                    startingStop = e.toString();
                  });
                
                }),
               DropDownList(bustops, destinationStop, "Destination Bus stop",
                    (e) async {
                  setState(() {
                    destinationStop = e.toString();
                  });
                
                }),
                
              
                TextButton(onPressed: (){
                  getRoute();
                  print(routeIndex);

                 var model=BusModel(0,busName,1,routeIndex,busNumber,"",getStopId(startingStop),getStopId(destinationStop),StartTime);
                  SupaBaseDatabase().InsertBusData(model);
                  print(busName);
                }, child: Text("Submit",style: TextStyle(fontSize: 25),))
              
            ],
          ),
        ),
      ),
    );
  }
}
