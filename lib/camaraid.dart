import 'dart:io';

import 'package:appocrall/idcard.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay/model.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ExampleCameraOverlay(),
  );
}

class ExampleCameraOverlay extends StatefulWidget {
  const ExampleCameraOverlay({Key? key}) : super(key: key);

  @override
  _ExampleCameraOverlayState createState() => _ExampleCameraOverlayState();
}

class _ExampleCameraOverlayState extends State<ExampleCameraOverlay> {
  OverlayFormat format = OverlayFormat.cardID1;
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (value) {
          setState(() {
            tab = value;
          });
          switch (value) {
            case (0):
              setState(() {
                format = OverlayFormat.cardID1;
              });
              break;
            case (1):
              setState(() {
                format = OverlayFormat.cardID3;
              });
              break;
            case (2):
              setState(() {
                format = OverlayFormat.simID000;
              });
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'บัตรกดเงินธนาคาร',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail), label: 'บัตรประชาชน'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sim_card), label: 'ซิมการ์ด'),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<CameraDescription>?>(
        future: availableCameras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'No camera found',
                    style: TextStyle(color: Colors.black),
                  ));
            }
            return CameraOverlay(snapshot.data!.first,
                CardOverlay.byFormat(format), (XFile file) => takeImage(file),
                // showDialog(
                //       context: context,
                //       barrierColor: Colors.black,
                //       builder: (context) {
                //         CardOverlay overlay = CardOverlay.byFormat(format);
                //         return AlertDialog(
                //             actionsAlignment: MainAxisAlignment.center,
                //             backgroundColor: Colors.black,
                //             title: const Text('Capture',
                //                 style: TextStyle(color: Colors.white),
                //                 textAlign: TextAlign.center),
                //             actions: [
                //               OutlinedButton(
                //                   onPressed: takeImage,
                //                   child: const Icon(Icons.close))
                //             ],
                //             content: SizedBox(
                //                 width: double.infinity,
                //                 child: AspectRatio(
                //                   aspectRatio: overlay.ratio!,
                //                   child: Container(
                //                     decoration: BoxDecoration(
                //                         image: DecorationImage(
                //                       fit: BoxFit.fitWidth,
                //                       alignment: FractionalOffset.center,
                //                       image: FileImage(
                //                         File(file.path),
                //                       ),
                //                     )),
                //                   ),
                //                 )));
                //       },
                //     ),
                info:
                    'วางบัตรประจำตัวของคุณภายในสี่เหลี่ยมผืนผ้าและตรวจดูให้แน่ใจว่ารูปภาพนั้นสามารถอ่านได้อย่างสมบูรณ์',
                label: 'กำลังถ่ายบัตรบัตรประชาชน');
          } else {
            return const Align(
                alignment: Alignment.center,
                child: Text(
                  'Fetching cameras',
                  style: TextStyle(color: Colors.black),
                ));
          }
        },
      ),
    ));
  }

  takeImage(XFile file) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return idcard(idFile: file);
    }));
  }
}
