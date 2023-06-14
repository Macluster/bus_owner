 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/BarChartModel.dart';
import '../Model/BusReportModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Bargraph extends StatefulWidget {
List<BarChartModel> data;


  Bargraph(this.data);

  @override
  State<Bargraph> createState() => _BargraphState();
}

class _BargraphState extends State<Bargraph> {


 

  @override
  Widget build(BuildContext context) {


    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
          id: "fare",
          data: widget.data,
          domainFn: (BarChartModel series, _) => series.variable,
          measureFn: (BarChartModel series, _) => series.fare,
          colorFn: (BarChartModel series, _) => series.color),
    ];
    // TODO: implement build
    return Container(
      height: 400,
      width: double.infinity,
      child: charts.BarChart(
        series,
        animate: true,
      ),
    );
  }
}
