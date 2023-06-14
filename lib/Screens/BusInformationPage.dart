import 'package:bus_owner/Backend/SupabaseDatabase.dart';
import 'package:bus_owner/Model/BusModel.dart';
import 'package:bus_owner/Model/ReviewModel.dart';
import 'package:bus_owner/Screens/BusReportPage.dart';
import 'package:flutter/material.dart';

import '../Components/ReviewCard.dart';

class BusInformationPage extends StatefulWidget {
  BusModel model;
  BusInformationPage(this.model);
  @override
  State<BusInformationPage> createState() => _BusInformationPageState();
}

class _BusInformationPageState extends State<BusInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [TextButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>BusReportPage(widget.model)));
                      }, child: Text("View Report"))],),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      widget.model.busName,
                      style: TextStyle(fontSize: 40,color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      widget.model.busNumber,
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ItemCard(Icons.location_on, widget.model.busCurrentLocation),
                    ItemCard(Icons.alarm, widget.model.startingTime),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children:  [
                        Text(
                          "Reviews",
                          style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                        future: SupaBaseDatabase().getReviews(widget.model.busId),
                        builder: (context, AsyncSnapshot<List<ReviewModel>> snap) {
                          if (!snap.hasData) {
                            return Text("Loading");
                          } else {
                            return Container(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: snap.data!.length,
                                  itemBuilder: (context, index) {
                                    return ReviewCard(snap.data![index]);
                                  }),
                            );
                          }
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ItemCard(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 100,
      width: double.infinity,
      decoration:BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 50,color: Color.fromARGB(255, 207, 205, 205),spreadRadius: 1)],
        
        color: Color.fromARGB(255, 241, 243, 243),borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(color: Color.fromARGB(255, 20, 28, 43), borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
