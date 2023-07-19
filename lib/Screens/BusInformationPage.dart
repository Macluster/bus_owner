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

  double width=0;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: FractionallySizedBox(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.model.busName + " Bus",
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                ItemCard("assets/images/location.png",
                                    widget.model.busCurrentLocation),
                                ItemCard("assets/images/waste.png",
                                    widget.model.startingTime),
                                ItemCard("assets/images/license-plate.png",
                                    widget.model.busNumber),
                                
                                const SizedBox(
                                  height: 50,
                                ),
                               Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reviews",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FutureBuilder(
                                    future: SupaBaseDatabase()
                                        .getReviews(widget.model.busId),
                                    builder: (context,
                                        AsyncSnapshot<List<ReviewModel>> snap) {
                                      if (!snap.hasData) {
                                        return Text("Loading");
                                      } else {
                                        return Container(
                                          height: 250,
                                          child: ListView.builder(
                                              itemCount: snap.data!.length,
                                              itemBuilder: (context, index) {
                                                return ReviewCard(
                                                    snap.data![index]);
                                              }),
                                        );
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FractionallySizedBox(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                   Navigator.push(context,MaterialPageRoute(builder:(context)=>BusReportPage(widget.model)));
                                },
                                child: Image.asset(
                                  "assets/images/document.png",
                                  height: 50,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget ItemCard(String icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 50,
      width: double.infinity,
     
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
           
             Image.asset(icon,height: 30,width: 30,),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300,color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
