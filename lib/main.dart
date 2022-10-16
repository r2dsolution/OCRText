import 'dart:convert';

import 'package:appocrall/camaraid.dart';
import 'package:appocrall/client_api%20(1).dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'ระบบ OCR บัตรประชชาชน'),
    );
  }
}

class OCRText extends StatefulWidget {
  @override
  _OCRTextState createState() => _OCRTextState();
}

class _OCRTextState extends State<OCRText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
        color: Colors.purple,
        child: Column(
          children: <Widget>[
            RaisedButton(
                textColor: Colors.black,
                color: Colors.blue,
                child: Text('กล้อง'),
                onPressed: testcamera),
            RaisedButton(
                textColor: Colors.black,
                color: Colors.blue,
                child: Text('ทดสอบ'),
                onPressed: testocr)
          ],
        ));
  }

  testocr() async {
    print('finish');
    String result = await ClientAPI.post('idcard', 'body');
    print('result= ${result}');
    print('result');
    Map<String, dynamic> map = jsonDecode(result);
    String greetings = map['greetings'] as String;
    print('${result}');
    print('${greetings}');
  }

  testcamera() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExampleCameraOverlay();
    }));
  }

  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);

    // You can use addPlugins if you are going to be adding multiple plugins
    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }
}

Future<void> _configureAmplify() async {
  // Add these lines, to include Auth and Storage plugins.
  final auth = AmplifyAuthCognito();
  final storage = AmplifyStorageS3();
  await Amplify.addPlugins([storage, auth]);
  try {
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    print('Tried to configure Amplify and following error occurred: $e');
  }
}

Future<void> createAndUploadFile() async {
  // Create a dummy file
  const exampleString = 'Example file contents';
  final tempDir = await getTemporaryDirectory();
  final exampleFile = File(tempDir.path + '/example.txt')
    ..createSync()
    ..writeAsStringSync(exampleString);

  // Upload the file to S3
  try {
    final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: exampleFile,
        key: 'ExampleKey',
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        });
    print('Successfully uploaded file: ${result.key}');
  } on StorageException catch (e) {
    print('Error uploading file: $e');
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
          child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.limeAccent[400],
            child: const Center(child: Text('กด กล้อง เพื่อถ่ายบัตรประชาชน')),
          ),
          Container(
              height: 300,
              //color: Colors.amber[500],
              child: OCRText()),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.red),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
            ),
            label: 'รูปภาพ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'ข้อมูลบัตรประชาชน',
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
