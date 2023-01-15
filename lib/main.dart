import 'package:flipr/authentication/login.dart';
import 'package:flipr/graph.dart';
import 'package:flipr/home.dart';
import 'package:flipr/market/BSE.dart';
import 'package:flipr/market/NSE.dart';
import 'package:flipr/stocks/Ashokley.dart';
import 'package:flipr/stocks/Cipla.dart';
import 'package:flipr/stocks/Eichermot.dart';
import 'package:flipr/stocks/Reliance.dart';
import 'package:flipr/stocks/Tatasteel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NSE(),
  ));
}
