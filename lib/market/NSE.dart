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
  List<String> itemsReturns = <String>[
    '1M',
    '1Y',
    '5Y'
  ];
  Color? returnsColor = Colors.red;
  Color? currentColor = Colors.red;
  String dropdownValueS= 'NSE';
  String dropdownValueR= '1M';
  double low=0.0;
  double high=0.0;
  double open=0.0;
  double previousClose=0.0;
  double current=0.0;
  dynamic low52;
  dynamic high52;
  double D1=0.0;
  double Dchange =0.0;
  double M1=0.0;
  double Mchange =0.0;
  double Y5=0.0;
  double Y5change =0.0;
  double Y1=0.0;
  double Y1change =0.0;
  double returns=0.0;
  double returnsChange =0.0;
  var flag=0;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late CrosshairBehavior _crosshairBehavior;
  final List<ChartData> chartData =<ChartData>[];
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
    _crosshairBehavior = CrosshairBehavior(enable: true);
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Future<void> getHttprequest() async {
    String url = "https://dataapiservice.onrender.com/NSE";
    print("hi");
    try{
      final response = await http.get(Uri.parse(url),headers: {'Content-Type':'application/json'});
      var data= jsonDecode(response.body);
      setState(() {
        low52=data[0]['Low'];
        high52=0.0;
        for( var i=0; i<1200;i++){
          var value=ChartData(date: DateFormat("dd-MM-yyyy").parse(data[i]['Date']), open: data[i]['Open'], high: data[i]['High'], low: data[i]['Low'], close: data[i]['Close']);
          chartData.add(value);
          print(i);
          print(value.low);
          print(value.high);
          //Data same from 734 to 737 so no change will occur so better to exclude i=736 which is null
          if(i!=736){
            if(low52>value.low){
              low52=value.low;
            }
            if(high52<value.high){
              high52=value.high;
            }
          }
          //
        }
        current=data[1234]['Close'];
        if(current==data[1234]['Close']){
          flag=1;
        }
        low=data[1234]['Low'];
        high=data[1234]['High'];
        open=data[1234]['Open'];
        previousClose=data[1233]['Close'];
        D1=data[1234]['Close']-data[1233]['Close'];
        Dchange=(D1/current)*100;
        M1=data[1234]['Close']-data[1203]['Close'];
        Mchange=(M1/current)*100;
        returns=M1;
        returnsChange=Mchange;
        if(D1>0)
        {
          currentColor=Colors.green;
        }
        else {
          currentColor=Colors.red;
        }
        if(returns>0)
        {
          returnsColor=Colors.green;
        }
        Y5=data[1234]['Close']-data[0]['Close'];
        Y5change=(Y5/current)*100;
        Y1=data[1234]['Close']-data[870]['Close'];
        Y1change=(Y1/current)*100;
      });
    }catch(e){
      print("catch/" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if(flag==1){
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
                            Text("NSE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Row(
                          children: [
                            Text(current.toString(),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold))
                          ],
                        ),
                        Row(
                          children: [
                            Text(D1.toString().substring(0,D1.toString().indexOf('.')+3),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: currentColor)),
                            Text('('+Dchange.toString().substring(0,Dchange.toString().indexOf('.')+3)+'%)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: currentColor))
                          ],
                        ),
                        Row(
                          children: [
                            Text("As on 13 Feb, 2023",style: TextStyle(fontSize: 12,color: Colors.grey[500]))
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text('Day Range',style: TextStyle(color: Colors.grey[600],fontSize: 18),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(low.toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
                            SizedBox(width: 160,),
                            Text(high.toString(),style: TextStyle(color: Colors.black,fontSize: 15),)
                          ],
                        ),
                        Row(
                          children: [
                            Text('L',style: TextStyle(color: Colors.red,fontSize: 15),),
                            Slider(
                              value: current,
                              onChanged: null,
                              min: low,
                              max: high,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black,
                              thumbColor: Colors.black,
                            ),
                            Text('H',style: TextStyle(color: Colors.green,fontSize: 15),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('52 week Range',style: TextStyle(color: Colors.grey[600],fontSize: 18),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(low52.toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
                            SizedBox(width: 155,),
                            Text(high52.toString(),style: TextStyle(color: Colors.black,fontSize: 15),)
                          ],
                        ),
                        Row(
                          children: [
                            Text('L',style: TextStyle(color: Colors.red,fontSize: 15),),
                            Slider(
                              value: current,
                              onChanged: null,
                              min: low52,
                              max: high52,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black,
                              thumbColor: Colors.black,
                            ),
                            Text('H',style: TextStyle(color: Colors.green,fontSize: 15),)
                          ],
                        ),
                        Row(
                          children: [
                            DropdownButton<String>(
                              onChanged: (String? newValue){
                                setState((){
                                  dropdownValueR=newValue!;
                                });
                                switch(newValue){
                                  case "1M" :
                                    returns=M1;
                                    returnsChange=Mchange;
                                    if(M1>0)
                                    {
                                      returnsColor=Colors.green;
                                    }
                                    break;
                                  case "1Y":
                                    returns=Y1;
                                    returnsChange=Y1change;
                                    if(Y1>0)
                                    {
                                      returnsColor=Colors.green;
                                    }
                                    break;
                                  case "5Y" :
                                    returns=Y5;
                                    returnsChange=Y5change;
                                    if(Y5>0)
                                    {
                                      returnsColor=Colors.green;
                                    }
                                    break;
                                }
                              },
                              value: dropdownValueR,
                              items: itemsReturns.map<DropdownMenuItem<String>>(
                                    (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                            ),
                            Text(returns.toString()+'('+returnsChange.toString().substring(0,returnsChange.toString().indexOf('.')+3)+'%)',style: TextStyle(fontSize: 15,color: returnsColor),)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Financials',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Open',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                Text(open.toString(),style: TextStyle(fontSize: 15,color: Colors.black)),
                                Text('Day Low',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                Text(low.toString(),style: TextStyle(fontSize: 15,color: Colors.black)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Previous Close',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                Text(previousClose.toString(),style: TextStyle(fontSize: 15,color: Colors.black)),
                                Text('52 Week High',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                Text(high52.toString(),style: TextStyle(fontSize: 15,color: Colors.black)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Day High',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                Text(high.toString(),style: TextStyle(fontSize: 15,color: Colors.black)),
                                Text('52 Week Low',style: TextStyle(fontSize: 15,color: Colors.grey)),
                                Text(low52.toString(),style: TextStyle(fontSize: 15,color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                        SfCartesianChart(
                          zoomPanBehavior: _zoomPanBehavior,
                          tooltipBehavior: _tooltipBehavior,
                          crosshairBehavior: _crosshairBehavior,
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
                              xValueMapper: (ChartData sales, _) => sales.date,
                              lowValueMapper: (ChartData sales, _) => sales.low,
                              highValueMapper: (ChartData sales, _) => sales.high,
                              openValueMapper: (ChartData sales, _) => sales.open,
                              closeValueMapper: (ChartData sales, _) => sales.close,
                              name: 'NSE',
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
    }else{
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child:
          CircularProgressIndicator()
          ,
        ),
      );
    }
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