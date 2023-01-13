import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    super.initState();
    _chartData=getChartData();
    _tooltipBehavior= TooltipBehavior(enable: true);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfCartesianChart(
            title: ChartTitle(text: 'Yearly sales analysis'),
            legend: Legend(isVisible: true),
            // tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[LineSeries<SalesData, double>(
              name: 'Sales',
              dataSource: _chartData,
              xValueMapper: (SalesData sales,_)=> sales.sales,
              yValueMapper: (SalesData sales,_)=> sales.year,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true
            )],
            primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
            primaryYAxis: NumericAxis(
                labelFormat: '{value}M',
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),

          ),
      )
    );
  }
  List<SalesData> getChartData(){
    final List<SalesData> chartData =[
      SalesData(2017,25),
      SalesData(2018, 12),
      SalesData(2019,40),
      SalesData(2020,10),
      SalesData(2021,28),
      SalesData(2022,49)
    ];
    return chartData;
  }
}

class SalesData{
  final double year;
  final double sales;
  SalesData(this.sales,this.year);
}
