import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late TooltipBehavior _tooltipBehavior;
  final List<FlSpot> spots =<FlSpot>[
    FlSpot(5, 3),
    FlSpot(9, 5)
  ];
    final List<ChartData> chartData =<ChartData>[
      // ChartData(
      //     date: DateFormat("yyyy-MM-dd").parse("2016-7-02"),
      //     open: 102.61,
      //     high: 105.85,
      //     low: 96.43,
      //     close: 96.96),
      // ChartData(
      //     date: DateFormat("yyyy-MM-dd").parse("2017-7-02"),
      //     open: 106.61,
      //     high: 105.85,
      //     low: 96.43,
      //     close: 96.96),
      // ChartData(
      //     date: DateFormat("yyyy-MM-dd").parse("2018-7-02"),
      //     open: 105.61,
      //     high: 101.85,
      //     low: 96.43,
      //     close: 96.96),
      // ChartData(
      //     date: DateFormat("yyyy-MM-dd").parse("2019-7-02"),
      //     open: 105.61,
      //     high: 105.85,
      //     low: 96.43,
      //     close: 96.96),

    ];
  @override
  void initState() {
    super.initState();
    getHttprequest();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Future<void> getHttprequest() async {
    print("hi");
    String url = "https://dataapiservice.onrender.com/Reliance";
    try{
      print("hi");
      final response = await http.get(Uri.parse(url),headers: {'Content-Type':'application/json'});
      var data= jsonDecode(response.body);
      setState(() {
        for( var i=0; i<512;i++){
          var value=ChartData(date: DateFormat("dd-MM-yyyy").parse(data[i]['Date']), open: data[i]['Open'], high: data[i]['High'], low: data[i]['Low'], close: data[i]['Close']);
          chartData.add(value);
          // print(DateFormat("dd-MM-yyyy").parse(data[i]['Date']));
          // var datas = ChartSampleData(date: data[i]['Date'], open: data[i]['Open']);
          spots.add(FlSpot(data[i]['Close'],data[i]['Open'] ));
          print(FlSpot(data[i]['Close'],data[i]['Open'] ));
          // print(i);
          // print(data[i]['Open']);
        }
      });
    }catch(e){
      print("catch/" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children:<Widget> [
              LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 11,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots
                    )
                  ]
                )
              )

          ])
        )
    );
  }
}

class ChartData{
  late String id;
  late DateTime date;
  late double open;
  late double high;
  late double low;
  late double close;
  late double adjClose;
  late double volume;
  ChartData({required this.date,required this.open,required this.high,required this.low,required this.close});
}
class ChartSampleData{
  late String id;
  late DateTime date;
  late double open;
  late double high;
  late double low;
  late double close;
  late double adjClose;
  late double volume;
  ChartSampleData({required this.date,required this.open});
}

//(double.parse(value!.the1Open.toString()),double.parse(value!.the2High.toString()), double.parse(value!.the3Low.toString()),double.parse(value!.the4Close.toString()))