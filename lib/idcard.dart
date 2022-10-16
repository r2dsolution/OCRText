import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(idcard());
// }

class idcard extends StatefulWidget {
  final XFile idFile;

  const idcard({super.key, required this.idFile});

  @override
  _idcardState createState() => _idcardState();
}

class _idcardState extends State<idcard> {
  @override
  Widget build(BuildContext context) {
    print('file size: ${widget.idFile.length()}');
    return new MaterialApp(
      title: "Basic Show Image",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("บัตรประชาชน"),
        ),
        body: new ListView(
          children: <Widget>[
            new Image.asset(
              'pngtree-invitation-card-background-hd-image_730851.jpg',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
