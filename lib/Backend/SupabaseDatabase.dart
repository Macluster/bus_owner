import 'dart:ffi';

import 'package:bus_owner/Model/NotificationModel.dart';
import 'package:bus_owner/Model/ReviewModel.dart';
import 'package:bus_owner/Model/UserModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/BusModel.dart';
import '../Model/BusReportModel.dart';
import 'FireBaseDatabase.dart';

class SupaBaseDatabase {
  final supabase = Supabase.instance.client;

  Future<List<BusModel>> GetBusData(int ownerID) async {
        var id=await getCurrentUserId();

    final data = await supabase.from('Buses').select().eq("ownerId", id);

    var list = data as List;

    List<BusModel> buslist = [];

    BusModel? model;
    var routes = await FirebaseDatabaseClass().getBusStopNameFromID();

    list.forEach((element) async {
      var busStopName =
          routes[element['busRoute']][element['busCurrentLocation']].toString();

      model = BusModel(
          element['busId'],
          element['busName'],
          1,
          element['busRoute'],
          element['busNumber'],
          busStopName,
          element['startStop'],
          element['endStop'],
          element['startingTime']);

      buslist.add(model!);
    });

    return buslist;
  }

  Future<List<NotificationModel>> getNotifications(int ownerId) async {
        var id=await getCurrentUserId();

    final data =
        await supabase.from('Notifications').select().eq("ownerId", id);
    var list = data as List;

    List<NotificationModel> Notlist = [];

    list.forEach((element) {
      Notlist.add(NotificationModel(element['id'], element['content'],
          element['who'], element['ownerId']));
    });

    return Notlist;
  }

  Future<int> getCurrentUserId() async {
    var email = Supabase.instance.client.auth.currentUser!.email;
    List data = await supabase
        .from("BusOwners")
        .select("ownerId")
        .eq("ownerEmail", email) as List;
    print("userId=" + data[0]['ownerId'].toString());

    return data[0]['ownerId'] as int;
  }

  Future<int> getTotalFare() async {
    var id=await getCurrentUserId();
    final data = await supabase.from('Payment').select().eq("ownerId", id);

    var list = data as List;
    int total = 0;
    list.forEach((element) {
      total = total + (element['busFare'] as int);
    });

    return total;
  }

  void InsertBusData(BusModel model) async {
        var id=await getCurrentUserId();

    print("routeIndex=" + model.startStop.toString());
    await supabase.from('Buses').insert({
      "busName": model.busName,
      "ownerId": id,
      "busRoute": model.busRoute,
      "busNumber": model.busNumber,
      "busCurrentLocation": 0,
      "startStop": model.startStop,
      "endStop": model.endStop,
      "startingTime": model.startingTime,
      "peopleInBus":0,
      "availableSeats":30,
      "averageSpeed":20
    });
  }

  Future<List<ReviewModel>> getReviews(int busId) async {
       
      

    final data = await supabase.from('Review').select().eq("busId", busId);
    var list = data as List;

    List<ReviewModel> reviewlist = [];

    for (int i = 0; i < list.length; i++) {
      var name = await supabase
          .from('Users')
          .select("userName")
          .eq("userId", list[i]['userId'])
          .single();

      reviewlist.add(ReviewModel(list[i]['id'], list[i]['review'],
          list[i]['rating'], name['userName']));
    }
    print(reviewlist);

    return reviewlist;
  }

  Future<List<BusReportModel>> getBusReport(int busId,String startDate,String endDate) async {
    
    List  data=[];
    if(startDate=="" || endDate==""||startDate=="null"||endDate=="null")
    {
   data = await supabase.from('Payment').select().eq("busId", busId);

    }
    else
    {
         data = await supabase.from('Payment').select().eq("busId", busId).lt("date", endDate).gt("date", startDate);

    }
    var list = data as List;

    List<BusReportModel> reportlist = [];

    print("sssssssssssssssssssssssssssssss");
    for (int i = 0; i < list.length; i++) {
      print("sssssssssssssssssssssssssssssss");
      var userData = await supabase
          .from('Users')
          .select("userName,userDob")
          .eq("userId", list[i]['userId'])
          .single();
      var busName = await supabase
          .from('Buses')
          .select("busName")
          .eq("busId", list[i]['busId'])
          .single();

      reportlist.add(BusReportModel(
          busName['busName'],
          userData['userName'],
          list[i]['date'],
          list[i]['fromBusStop'],
          list[i]['toBusStop'],
          list[i]['busFare'],userData['userDob']));
    }

    return reportlist;
  }

  Future<Map<String, double>> getNumberOFTypesOfPeople(int id)async
  {

      var data = await supabase
            .from('Payment')
            .select("userId")
            .eq("busId", id);


      var list =data as List;

      var stlist=[];
      var clist=[];

    
      for(int i=0;i<list.length;i++)
      {
        List stdata=await supabase.from("StCard").select("stId").eq("userId",list[i]['userId']);
        if(stdata.isNotEmpty)
        {
          stlist.add(list[i]['userId']);
        }

      }

      for(int i=0;i<list.length;i++)
      {
        List stdata=await supabase.from("SeniorCitizens").select("cid").eq("userId",list[i]['userId']);
        if(stdata.isNotEmpty)
        {
          clist.add(list[i]['userId']);
        }

      }
 
          return {"Elder People":stlist.length.toDouble(),"Student":clist.length.toDouble(),"Other":(list.length-stlist.length+clist.length).toDouble()};
          

  }

   void AddUserDetails(BusOwnerModel model) async {
    await supabase.from("BusOwners").insert({
      "ownerName": model.ownerName,
      "ownerNumber": model.ownerNumber,
      "ownerEmail": model.ownerEmail,
      "ownerAddress": model.ownerAddress,
      
    });
  }



}
