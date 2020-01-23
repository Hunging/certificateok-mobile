import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class ScanScreen extends StatefulWidget{
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen>{
  String barcode = "";
      @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: RaisedButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: scan,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.scanner, size: 35,),
                      SizedBox(width: 10,),
                      Column(
                        children: <Widget>[
                          Text('QR code scam', style: TextStyle(fontSize: 20,),),
                          SizedBox(height: 5,),
                          Text("Click here")
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Future scan() async{
    try{
      String barcode  = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
      });
    } on PlatformException catch (e){
      if (e.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          this.barcode = "Camera permission not granted";
        });
      }else{
        setState(() {
          this.barcode = "Unknown error: $e";
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = "null (User returned using the Back button before scanning anything, Result)";
      });
    }catch (e){
      setState(() {
        this.barcode = "Unknown error: $e";
      });
    }
  }
}

