import 'package:bus_owner/Screens/InputBusDetailsPage.dart';
import 'package:flutter/material.dart';

import '../Backend/SupabaseDatabase.dart';
import '../Components/BusCard.dart';
import '../Model/BusModel.dart';

class MyBusesPage extends StatefulWidget {
  String heading = "My Buses";
  @override
  State<MyBusesPage> createState() => _MyBusesPageState();
}

class _MyBusesPageState extends State<MyBusesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 40,),
                  FutureBuilder(
                      future: SupaBaseDatabase().GetBusData(1),
                      builder: (context, AsyncSnapshot<List<BusModel>> snap) {
                        if (snap.hasData) {
                          return Container(
                            height: 450,
                            child: ListView.builder(
                                itemCount: snap.data!.length,
                                itemBuilder: (context, index) {
                                  return BusCard(snap.data![index]);
                                }),
                          );
                        } else {
                          return Text("loading");
                        }
                      }),
                ],
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InputBusDetailsPage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                          gradient: SweepGradient(
                            colors: [
                              Color(0xff9796F0),
                              Color(0xffFBC7D4),
                            ],
                            stops: [0, 1],
                            center: Alignment.topLeft,
                          ),
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                  
                          child: Text("+",style: TextStyle(color: Colors.white,fontSize: 30),),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }



  


}
