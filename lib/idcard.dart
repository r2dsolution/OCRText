import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(idcard());
}

class idcard extends StatefulWidget {
  @override
  _idcardState createState() => _idcardState();
}

class _idcardState extends State<idcard> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Basic Show Image",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("บัตรประชาชน"),
        ),
        body: new ListView(
          children: <Widget>[
            new Image.asset(
              'unnamed (1).png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
