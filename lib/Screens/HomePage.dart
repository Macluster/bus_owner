import 'package:bus_owner/Backend/SupabaseDatabase.dart';
import 'package:bus_owner/Components/NotificationCard.dart';
import 'package:bus_owner/Model/NotificationModel.dart';
import 'package:flutter/material.dart';

import '../Components/BusCard.dart';
import '../Model/BusModel.dart';

class HomPage extends StatefulWidget {

  String heading="Homepage";
  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SupaBaseDatabase().getTotalFare();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 100,),
              FutureBuilder(
                future: SupaBaseDatabase().getTotalFare(),
                builder: (context,AsyncSnapshot<int> snap){
                if(snap.hasData)
                {
                  return  Text("${snap.data.toString()} Rs",style: const TextStyle(fontSize: 60,fontWeight: FontWeight.bold),);
                }
                else
                {
                  return Text("Loading");
                }
              }),
             
              Text("Total Profit",style: TextStyle(color: Colors.grey, fontSize: 23),),
              SizedBox(height: 50,),
              Row(children: const[
                Text("Notifications",style: TextStyle(fontSize: 23),),
             
              ],),
              SizedBox(height: 20,),
                 FutureBuilder(
                  future: SupaBaseDatabase().getNotifications(1),
                  builder: (context,AsyncSnapshot<List<NotificationModel>> snap){
                    if(snap.hasData)
                    {
                      return Container(
                        height: 450,
                        child: ListView.builder(
                          
                          itemCount: snap.data!.length,
                          itemBuilder: (context,index){
                            return NotificationCard(snap.data![index]);
                      
                        }),
                      );
                    }
                    else
                    {
                      return Text("loading");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
