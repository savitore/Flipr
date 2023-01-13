import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getHttprequest();
  }
  void getHttprequest() async{
    String url ="url";
    var response = await http.get(Uri.parse(url));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
