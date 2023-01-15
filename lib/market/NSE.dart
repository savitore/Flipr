import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../stocks/Ashokley.dart';
import '../stocks/Cipla.dart';
import '../stocks/Eichermot.dart';
import '../stocks/Reliance.dart';
import '../stocks/Tatasteel.dart';
import 'BSE.dart';

class NSE extends StatefulWidget {
  const NSE({Key? key}) : super(key: key);

  @override
  State<NSE> createState() => _NSEState();
}

class _NSEState extends State<NSE> {
  List<String> itemsStocks = <String>[
    'BSE',
    'NSE',
    'ASHOKLEYLAND',
    'CIPLA',
    'EICHERMOTORS',
    'RELIANCE',
    'TATASTEEL',
  ];
  String dropdownValueS= 'NSE';
  late TooltipBehavior _tooltipBehavior;
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
    super.initState();
    getHttprequest();
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
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Future<void> getHttprequest() async {
    String url = "https://dataapiservice.onrender.com/NSE";
    try{
      final response = await http.get(Uri.parse(url),headers: {'Content-Type':'application/json'});
      var data= jsonDecode(response.body);
      setState(() {
        for( var i=0; i<1235;i++){
          var value=ChartData(date: DateFormat("dd-MM-yyyy").parse(data[i]['Date']), open: data[i]['Open'], high: data[i]['High'], low: data[i]['Low'], close: data[i]['Close']);
          chartData.add(value);
          print(i);
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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
                          Text("NIFTY 50",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Row(
                        children: [
                          Text("17,972.15",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.arrow_drop_up,color: Colors.green,size: 25,),
                          Text("113.95(0.64%)",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green))
                        ],
                      ),
                      Row(
                        children: [
                          Text("As on 13 Feb, 2023",style: TextStyle(fontSize: 12,color: Colors.grey[500]))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Day Range',style: TextStyle(color: Colors.grey[500],fontSize: 20),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('17,774.25',style: TextStyle(color: Colors.black,fontSize: 20),),
                          SizedBox(width: 150,),
                          Text('17,976.40',style: TextStyle(color: Colors.black,fontSize: 20),)
                        ],
                      ),
                      Row(
                        children: [
                          Text('L',style: TextStyle(color: Colors.red,fontSize: 15),),
                          Divider(
                            thickness: 1,
                            color: Colors.black
                            ,),
                          Text('R',style: TextStyle(color: Colors.green,fontSize: 15),)
                        ],
                      ),
                      SfCartesianChart(
                        zoomPanBehavior: _zoomPanBehavior,
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
                            dataSource: chartData,
                            xValueMapper: (ChartData sales, _) => sales.date,
                            lowValueMapper: (ChartData sales, _) => sales.low,
                            highValueMapper: (ChartData sales, _) => sales.high,
                            openValueMapper: (ChartData sales, _) => sales.open,
                            closeValueMapper: (ChartData sales, _) => sales.close,
                            name: 'Reliance',
                          )
                        ],
                        primaryXAxis: DateTimeAxis(
                          // minimum: DateTime(2018),
                          // maximum: DateTime(2023)
                        ),
                        // NumericAxis(
                        //     edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(),
                      ),
                    ]
                ),
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