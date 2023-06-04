

import 'package:bus_owner/Model/NotificationModel.dart';
import 'package:bus_owner/Model/ReviewModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/BusModel.dart';
import 'FireBaseDatabase.dart';



class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  Future<List<BusModel>> GetBusData(int ownerID) async {
    final data = await supabase.from('Buses').select().eq("ownerId", ownerID);

    var list = data as List;

    List<BusModel> buslist = [];

    BusModel? model;
    var routes = await FirebaseDatabaseClass().getBusStopNameFromID();

    list.forEach((element) async {
      var busStopName = routes[element['busRoute']][element['busCurrentLocation']].toString();

      model = BusModel(element['busId'], element['busName'], 1,element['busRoute'], element['busNumber'], busStopName, element['startStop'], element['endStop'], element['startingTime']);

      buslist.add(model!);
    });


    return buslist;
  }


  Future<List<NotificationModel>> getNotifications(int ownerId)async
  {
       final data = await supabase.from('Notifications').select().eq("ownerId", ownerId);
        var list = data as List;

    List<NotificationModel> Notlist = [];

    

    list.forEach((element) { 
        Notlist.add(NotificationModel(element['id'],element['content'],element['who'],element['ownerId']));
      
    });

    return Notlist;

  }
  Future<int> getCurrentUserId() async {
    var email = Supabase.instance.client.auth.currentUser!.email;
    List data = await supabase.from("Users").select("userId").eq("userEmail", email) as List;
    print("userId=" + data[0]['userId'].toString());

    return data[0]['userId'] as int;
  }

  Future<int> getTotalFare()async
  {
     final data = await supabase.from('Payment').select().eq("ownerId", 1);

     var list=data as List;
      int total=0;
     list.forEach((element) { 

      total=total+(element['busFare']as int);
     });
         
     return total;
  }



  void InsertBusData(BusModel model)async
  {
    print("routeIndex="+model.startStop.toString());
    await  supabase.from('Buses').insert({"busName":model.busName,"ownerId":model.ownerId,"busRoute":model.busRoute, "busNumber":model.busNumber,
    "busCurrentLocation":0,"startStop":model.startStop,"endStop":model.endStop, "startingTime":model.startingTime});
  }

  Future<List<ReviewModel>> getReviews(int busId)async
  {
        final data = await supabase.from('Review').select().eq("busId", busId);
         var list=data as List;

         List<ReviewModel> reviewlist=[];


         for (int i=0;i<list.length;i++)
         {
              var name= await supabase.from('Users').select("userName").eq("userId", list[i]['userId']).single();
                
                reviewlist.add(ReviewModel(list[i]['id'], list[i]['review'], list[i]['rating'],name['userName']));

         }
         print(reviewlist);

         return reviewlist;

        
  }
}
