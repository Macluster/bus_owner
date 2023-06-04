import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseClass {
  Future<List> GetRoute() async {
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var data = snap.value as List;

    return data;
  }

   Future<List<dynamic>> getBusStopNameFromID()async
  {
        final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var routes = snap.value as List;

       return routes;
       
  }

  Future<Map> gerRouteIdAndBusStops(String StartStop ,String DestinationStop)async
  { 
    
    final databaseRef = FirebaseDatabase.instance.ref();
    var snap = await databaseRef.child('Routes').get();
    var myRoot = [];
    var routes = snap.value as List;
    var routeIndex=0;
         routes.asMap().forEach((index, route) {
      if (route.contains(StartStop) && route.contains(DestinationStop)) {
        routeIndex = index;
       
        int currentstopIndex = route.indexOf(StartStop);
        int destinationStopIndex = route.indexOf(DestinationStop);
       
        for (int i = currentstopIndex; i <= destinationStopIndex; i++) {
          myRoot.add(routes[routeIndex][i]);
        }
      }
    });



    return {"routeIndex":routeIndex,"busStops":myRoot};
  }



  
  
}
