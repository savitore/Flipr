import 'package:flipr/market/BSE.dart';
import 'package:flipr/market/NSE.dart';
import 'package:flipr/stocks/Ashokley.dart';
import 'package:flipr/stocks/Cipla.dart';
import 'package:flipr/stocks/Eichermot.dart';
import 'package:flipr/stocks/Reliance.dart';
import 'package:flipr/stocks/Tatasteel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('STOCK MARKET'),
        centerTitle: true,
      ),
      body: Column(
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
    );
  }
}
