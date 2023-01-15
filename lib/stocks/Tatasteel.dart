import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../market/BSE.dart';
import '../market/NSE.dart';
import 'Ashokley.dart';
import 'Cipla.dart';
import 'Eichermot.dart';
import 'Reliance.dart';

class Tatasteel extends StatefulWidget {
  const Tatasteel({Key? key}) : super(key: key);

  @override
  State<Tatasteel> createState() => _TatasteelState();
}

class _TatasteelState extends State<Tatasteel> {
  List<String> itemsStocks = <String>[
    'BSE',
    'NSE',
    'ASHOK LEYLAND',
    'CIPLA',
    'EICHER MOTORS',
    'RELIANCE',
    'TATA STEEL',
  ];
  String dropdownValueS= 'TATA STEEL';
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
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
    _zoomPanBehavior = ZoomPanBehavior(
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey,
      enableDoubleTapZooming: true,
        enableMouseWheelZooming : true,
        zoomMode: ZoomMode.x,
        enablePanning: true
    );
    super.initState();
    getHttprequest();
    _crosshairBehavior = CrosshairBehavior(enable: true);
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Future<void> getHttprequest() async {
    String url = "https://dataapiservice.onrender.com/TataSteel";
    try{
      print("hi");
      final response = await http.get(Uri.parse(url),headers: {'Content-Type':'application/json'});
      var data= jsonDecode(response.body);
      setState(() {
        for( var i=0; i<1235;i++){
          var value=ChartData(date: DateFormat("dd-MM-yyyy").parse(data[i]['Date']), open: data[i]['Open'], high: data[i]['High'], low: data[i]['Low'], close: data[i]['Close']);
          chartData.add(value);
          // print(DateFormat("dd-MM-yyyy").parse(data[i]['Date']));
          print(i);
          print(data[i]['Open']);
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children:<Widget> [
                      Row(
                        children: [
                          DropdownButton<String>(
                            onChanged: (String? newValue){
                              setState((){
                                dropdownValueS=newValue!;
                              });
                              switch(newValue){
                                case "BSE" :
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> BSE()
                                  ));
                                  break;
                                case "NSE":
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> NSE()
                                  ));
                                  break;
                                case "ASHOKLEYLAND" :
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> AshokLey()
                                  ));
                                  break;
                                case "CIPLA" :
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> Cipla()
                                  ));
                                  break;
                                case "EICHERMOTORS" :
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> Eichermot()
                                  ));
                                  break;
                                case "RELIANCE" :
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> Reliance()
                                  ));
                                  break;
                                case "TATASTEEL" :
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> Tatasteel()
                                  ));
                                  break;
                              }
                            },
                            value: dropdownValueS,
                            items: itemsStocks.map<DropdownMenuItem<String>>(
                                  (String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Tata Steel',style: TextStyle(fontSize: 15),),
                          SizedBox(width: 4,),
                          Icon(Icons.circle,size: 4,color: Colors.grey,),
                          SizedBox(width: 4,),
                          Text('1D',style: TextStyle(fontSize: 15),),
                          SizedBox(width: 4,),
                          Icon(Icons.circle,size: 4,color: Colors.grey,),
                          SizedBox(width: 4,),
                          Text('NSE',style: TextStyle(fontSize: 15),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text('1m'),
                        SizedBox(width: 8,),
                        Text('3m'),
                        SizedBox(width: 8,),
                        Text('5m'),
                        SizedBox(width: 8,),
                        Text('15m'),
                        SizedBox(width: 8,),
                        Text('30m'),
                        SizedBox(width: 8,),
                        Text('1h'),
                          SizedBox(width: 8,),
                          Text('D',style: TextStyle(color: Colors.blue),),
                          SizedBox(width: 8,),
                          Text('W',style: TextStyle(color: Colors.black),),
                          SizedBox(width: 8,),
                          Icon(Icons.keyboard_arrow_down),
                          SizedBox(width: 20,)
                      ],),
                      SfCartesianChart(
                        zoomPanBehavior: _zoomPanBehavior,
                        // legend: Legend(isVisible: true),
                        axes: [
                          NumericAxis(
                              opposedPosition: true,
                              name: 'indicator'
                          )
                        ],
                        // indicators: <TechnicalIndicators<ChartData, DateTime?>>[
                        //   AtrIndicator<ChartData, DateTime?>(
                        //       seriesName: 'IBM', period: 3, yAxisName: 'indicator'),
                        // ],
                        series: <ChartSeries<ChartData, DateTime?>>[
                          HiloOpenCloseSeries<ChartData, DateTime?>(
                            enableTooltip: true,
                            dataSource: chartData,
                            xValueMapper: (ChartData sales, _) => sales.date as DateTime,
                            lowValueMapper: (ChartData sales, _) => sales.low,
                            highValueMapper: (ChartData sales, _) => sales.high,
                            openValueMapper: (ChartData sales, _) => sales.open,
                            closeValueMapper: (ChartData sales, _) => sales.close,
                            name: 'TATA STEEL',
                          )
                        ],
                        primaryXAxis: DateTimeAxis(),
                        tooltipBehavior: _tooltipBehavior,
                        crosshairBehavior: _crosshairBehavior,
                        // NumericAxis(
                        //     edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(),
                      ),

                    ]),
              ),
            )
        )
    );
  }
}

class ChartData{
  late String id;
  late DateTime date;
  late dynamic open;
  late dynamic high;
  late dynamic low;
  late dynamic close;
  late dynamic adjClose;
  late dynamic volume;
  ChartData({required this.date,required this.open,required this.high,required this.low,required this.close});
}

//(double.parse(value!.the1Open.toString()),double.parse(value!.the2High.toString()), double.parse(value!.the3Low.toString()),double.parse(value!.the4Close.toString()))