import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'device_info.dart';





void main() => runApp(MaterialApp(

      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String result = "Hey there !";
  
    var _ipAddress = 'Unknown';
  final httpClient = new Client();
  final url = 'https://httpbin.org/ip';
  _getIPAddressUsingFuture() {
    Future<Response> response = httpClient.get(url);
    response.then((value) {
      setState(() {
        _ipAddress = json.decode(value.body)['origin'];
      });
    }).catchError((error) => print(error));
  }


  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "No Data $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }
  



  @override
  Widget build(BuildContext context) {

    final deviceinfoButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.of(context).pushNamed(DeviceinfoPage.tag);
          },
          color: Colors.lightBlueAccent,
          child: Text('Device Info', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final scanButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            _scanQR();
          },
          color: Colors.lightBlueAccent,
          child: Text('Scan QR Code', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    final ipAddressButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            _getIPAddressUsingFuture();
          },
          color: Colors.lightBlueAccent,
          child: Text('Ip Address', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  
    
    
   return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text(
              'Home'),
        ),      
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0,top: 24.0),
          children: <Widget>[
            Text("IP Address result : "+_ipAddress,),
            Text("QR Code result : "+result),
            ipAddressButton,
            scanButton,
            deviceinfoButton
          ],
        ),
      ),
    ));
    
  }

          

    
}