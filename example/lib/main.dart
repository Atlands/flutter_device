import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_device/flutter_device.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(path: '/', builder: (context, state) => const RootPage()),
    GoRoute(
        name: 'detail',
        path: '/d',
        builder: (_, state) {
          var id = state.uri.queryParameters['id'];
          return Scaffold(
            body: Text('$id'),
          );
        }),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {
                      var sys = FlutterDevice.getSystem();
                      print(sys);
                    },
                    child: const Text('get system ')),
                ElevatedButton(
                    onPressed: () async {
                      var result = await FlutterDevice.getReferrer();
                      print(result);
                    },
                    child: Text("referrer")),
                ElevatedButton(
                    onPressed: () async {
                      var result = await FlutterDevice.contactPicker();
                      print(result);
                    },
                    child: Text("contact picker")),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var result = await FlutterDevice.cameraPicker(
                            front: true,
                            imageQuality: 10,
                            maxWidth: 100,
                            maxHeight: 100);
                        print(result);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('camera picker')),
                ElevatedButton(
                    onPressed: () async {
                      var result = await FlutterDevice.getPackageInfo();
                      print(result.versionName);
                    },
                    child: Text("Package Info")),
                ElevatedButton(
                    onPressed: () async {
                      var result = await FlutterDevice.getApps();
                      print(result);
                    },
                    child: Text("all app")),
                ElevatedButton(
                    onPressed: () async {
                      var result = await FlutterDevice.getPosition();
                      print(result);
                    },
                    child: Text("location")),
                ElevatedButton(
                    onPressed: () async {
                      var result = await FlutterDevice.getPhotos();
                      print(result);
                    },
                    child: Text("all photo")),
                ElevatedButton(
                    onPressed: () async {
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
                ElevatedButton(
                    onPressed: () async {
                      var res = await FlutterDevice.getDeviceInfo();
                      // print(res);
                      context.goNamed('detail',
                          queryParameters: {'id': jsonEncode(res)});
                    },
                    child: Text('next page'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
