import 'package:bus_owner/Backend/SupabaseDatabase.dart';
import 'package:bus_owner/Components/WeeklyBargraph.dart';
import 'package:bus_owner/Model/BarChartModel.dart';
import 'package:bus_owner/Model/BusReportModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../Model/BusModel.dart';

class BusReportPage extends StatefulWidget {
  BusModel model;
  BusReportPage(this.model);

  @override
  State<BusReportPage> createState() => _BusReportPageState();
}

class _BusReportPageState extends State<BusReportPage> {
  String startDate = "";
  String endDate = "";

  bool ReportFlag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStartAndEnddateOfWeek();
  }

  void getStartAndEnddateOfWeek() {
    var date = DateTime.now();
    var weekDay = date.weekday;

    startDate =
        date.subtract(Duration(days: weekDay - 1)).toString().split(" ")[0];
    endDate = date.add(Duration(days: 7 - weekDay)).toString().split(" ")[0];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Bus Report",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () async {
                                var sDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 500)),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 500)));
                                print(startDate);
          
                                startDate = sDate.toString().split(" ")[0];
                                if (startDate == "null") {
                                  startDate = "";
                                  Fluttertoast.showToast(msg: "Select a Date");
                                }
          
                                setState(() {});
                              },
                              child: Text(
                                  startDate == "" ? "Start Date" : startDate)),
                          TextButton(
                              onPressed: () async {
                                var eDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 500)),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 500)));
                                endDate = eDate.toString().split(" ")[0];
                                if (endDate == "null") {
                                  endDate = "";
                                  Fluttertoast.showToast(msg: "Select a Date");
                                }
                                setState(() {});
                              },
                              child: Text(endDate == "" ? "End Date" : endDate)),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              ReportFlag = ReportFlag == false ? true : false;
                            });
                          },
                          child: Text(ReportFlag == false
                              ? "View analytics"
                              : "View Records"))
                    ],
                  ),
                  // TableView(widget.model, startDate, endDate)
                  FutureBuilder(
                      future: SupaBaseDatabase()
                          .getBusReport(widget.model.busId, startDate, endDate),
                      builder:
                          (context, AsyncSnapshot<List<BusReportModel>> snap) {
                        if (snap.hasData) {
                          return ReportFlag == false
                              ? TableView(snap, startDate, endDate)
                              : GraphView(snap, startDate, endDate);
                        } else {
                          return Text("Loading");
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget TitleCard(String title, Color color) {
  return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(1),
      color: color,
      height: 30,
      width: 100,
      child: Text(title));
}

Widget RecordCard(BusReportModel model) {
  return Container(
    child: Row(
      children: [
        TitleCard(model.userName, Color.fromARGB(255, 173, 110, 110)),
        TitleCard(model.fromBusstop, Color.fromARGB(255, 173, 110, 110)),
        TitleCard(model.toBusStop, Color.fromARGB(255, 173, 110, 110)),
        TitleCard(model.date, Color.fromARGB(255, 173, 110, 110)),
        TitleCard(model.fare.toString(), Color.fromARGB(255, 173, 110, 110)),
      ],
    ),
  );
}

class TableView extends StatelessWidget {
  AsyncSnapshot<List<BusReportModel>> snap;
  String startDate;
  String endDate;

  TableView(this.snap, this.startDate, this.endDate);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleCard("Bus Name", Colors.amber),
            Container(
              height: 400,
              width: 100,
              child: ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    return TitleCard(
                        snap.data![index].busName, Colors.lightBlue);
                  }),
            )
          ],
        ),
        Container(
          width: width - 135,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleCard("User Name", Colors.amber),
                    TitleCard("from", Colors.amber),
                    TitleCard("to", Colors.amber),
                    TitleCard("Date", Colors.amber),
                    TitleCard("Fare", Colors.amber),
                  ],
                ),
                Container(
                  height: 400,
                  width: 510,
                  child: ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) {
                        return RecordCard(snap.data![index]);
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GraphView extends StatefulWidget {
  AsyncSnapshot<List<BusReportModel>> snap;
  String startDate;
  String endDate;
  GraphView(this.snap, this.startDate, this.endDate);

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  List<BarChartModel> data = [];
  List<BarChartModel> data2 = [];

  void getPeopleByDate() {
    var agelist = [0,0,0,0];
    widget.snap.data!.forEach((element) {
      var dobYear = element.userDob.split("-")[0];

      int age = DateTime.now().year - int.parse(dobYear);
      print(age);

      if (age >= 10 && age < 20) {
        agelist[0] = agelist[0] + 1;
      } else if (age >= 20 && age < 30) {
        agelist[1] = agelist[1] + 1;
      } else if (age >= 30 && age < 50) {
        agelist[2] = agelist[2] + 1;
      } else if (age >= 50 && age < 70) {
        agelist[3] = agelist[3] + 1;
      }

      data2 = [
        BarChartModel(
            variable: "10-20",
            fare: agelist[0],
            color: charts.ColorUtil.fromDartColor(Colors.amber)),
        BarChartModel(
            variable: "20-30",
            fare: agelist[1],
            color: charts.ColorUtil.fromDartColor(Colors.amber)),
        BarChartModel(
            variable: "30-50",
            fare: agelist[2],
            color: charts.ColorUtil.fromDartColor(Colors.amber)),
        BarChartModel(
            variable: "60-70",
            fare: agelist[3],
            color: charts.ColorUtil.fromDartColor(Colors.amber)),
      ];
    });

    setState(() {});
  }

  void getFareOfEachDay() {
    var fares = [0, 0, 0, 0, 0, 0, 0];
    widget.snap.data!.forEach((element) {
      var date = DateTime(
          int.parse(element.date.split("-")[0]),
          int.parse(element.date.split("-")[1]),
          int.parse(element.date.split("-")[2]));
      fares[date.weekday] = fares[date.weekday] + element.fare;
    });
    print("fares=");
    print(fares);

    data = [
      BarChartModel(
          variable: "Sun",
          fare: fares[0],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
      BarChartModel(
          variable: "Mon",
          fare: fares[1],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
      BarChartModel(
          variable: "Tue",
          fare: fares[2],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
      BarChartModel(
          variable: "Wed",
          fare: fares[3],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
      BarChartModel(
          variable: "Thu",
          fare: fares[4],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
      BarChartModel(
          variable: "Fri",
          fare: fares[5],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
      BarChartModel(
          variable: "Sat",
          fare: fares[6],
          color: charts.ColorUtil.fromDartColor(Colors.amber)),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getFareOfEachDay();
    getPeopleByDate();
    // TODO: implement build
    return Column(
      children: [
        SizedBox(height: 50,),
         const  Align(
        alignment: Alignment.centerLeft,
        child: Text("Total fares per each day",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),)),
         SizedBox(height: 30,),
        Bargraph(data), 
      

      SizedBox(height: 100,),
    const  Align(
        alignment: Alignment.centerLeft,
        child: Text("People in age range",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),)),
         SizedBox(height: 30,),
      Bargraph(data2)],
    );
  }
}
