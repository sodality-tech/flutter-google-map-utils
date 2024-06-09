import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_map_utils/google_map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LatLng _offsetLocation = const LatLng(0, 0);
  final _googleMapUtilsPlugin = GoogleMapUtils();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    LatLng offsetLocation;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      offsetLocation = await _googleMapUtilsPlugin.getGeometryOffset(
        from: LatLng(0, 0),
        direction: 60,
        distance: 500,
      );
    } on PlatformException {
      offsetLocation = const LatLng(0, 0);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _offsetLocation = offsetLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_offsetLocation\n'),
        ),
      ),
    );
  }
}
