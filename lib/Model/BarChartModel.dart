import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartModel
{

  String variable;
  int fare;
  charts.Color color;
  BarChartModel({required this.variable, required this.fare,required this.color});
}