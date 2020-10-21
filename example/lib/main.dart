import 'package:flutter/material.dart';
import 'package:local_ip/local_ip.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _ipStr = '0.0.0.0';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_ipStr),
          centerTitle: true,
        ),
        body: Center(
          child: RaisedButton(
            child: Text("GetIp"),
            onPressed: _getIp,
          ),
        ),
      ),
    );
  }

  _getIp() async {
    var ip = await LocalIp.ip;
    print(ip);
    setState(() {
      _ipStr = ip;
    });
  }
}
