import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:student_attendence/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
String result;

Future _scanQR() async{
  var result;
 try{
   var qrResult = await BarcodeScanner.scan();
   setState(() {
    result = qrResult;
   });
 }on PlatformException catch(e){
   if(e.code == BarcodeScanner.cameraAccessDenied){
      setState(() {
       this.result = "Camera permission deny";
      });
   }else{
     setState(() {
       this.result = "Unknown $e";
     });
   }
 }on FormatException{
   setState(() {
     this.result = "You pressed back button before scan";
   });
 }catch(e){
   setState(() {
     this.result = "Unknown error $e";
   });
 }
}


  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('EASY QR'),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign Out'),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          result.toString(),
        ),
      ),
      floatingActionButton:FloatingActionButton.extended(
       icon: Icon(Icons.camera_alt),
        label: Text('Scan'),
          // Within the `FirstRoute` widget
          onPressed: _scanQR,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
