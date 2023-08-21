import 'package:flutter/material.dart';
import 'package:flutter_device/flutter_device.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  // final _flutterDevicePlugin = FlutterDevice();

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion = await _flutterDevicePlugin.getPlatformVersion() ??
  //         'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var result = await FlutterDevice.contactPicker();
                        print(result);
                      },
                      child: Text("contact picker")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          var result =
                              await FlutterDevice.cameraPicker(font: true);
                          print(result);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('camera picker')),
                  ElevatedButton(onPressed: ()async{
                    var result = await FlutterDevice.getPackageInfo();
                    print(result);
                  }, child: Text("Package Info")),
                  ElevatedButton(onPressed: () async {
                    var result= await FlutterDevice.getPosition();
                    print(result);
                  }, child: Text("location")),
                  ElevatedButton(onPressed: () async {
                    var result = await FlutterDevice.getPhotos();
                    print(result);
                  }, child: Text("all photo")),
                  ElevatedButton(onPressed: () async {
                    var result = await FlutterDevice.getContacts();
                        print(result);
                      },
                      child: Text("all contact")),
                  ElevatedButton(
                      onPressed: () async {
                        var result = await FlutterDevice.getCalendars();
                        print(result);
                      },
                      child: Text("all calendar")),
                  ElevatedButton(
                      onPressed: () async {
                        var result = await FlutterDevice.getDeviceInfo();
                        print(result);
                      },
                      child: Text("get device")),
                  ElevatedButton(
                      onPressed: () async {
                        var result = await FlutterDevice.getMessages();
                        print(result);
                      },
                      child: Text("get sms")),
                  ElevatedButton(
                      onPressed: () async {
                        var st = {"sms": "2019-06-14 13:39:08"};
                        var result = await FlutterDevice.savePreferences(st);
                        print(result);
                      },
                      child: Text("save preference")),
                  ElevatedButton(
                      onPressed: () async {
                        var result = await FlutterDevice.cleanPreferences();
                        print(result);
                      },
                      child: Text("clean preference")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
