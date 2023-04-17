import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:mobiiot_printer/mobiiot_printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _printer = MobiiotPrinter();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> printReceipt() async {
    bool? connected = await MobiiotPrinter.bindingPrinter();
    debugPrint(connected.toString());
    if(connected == true) {
      await MobiiotPrinter.sync(false);
      try {
        Uint8List bytes = (await rootBundle.load('assets/images/logo.jpeg'))
            .buffer
            .asUint8List();
        await MobiiotPrinter.setAlignment(1);
        await MobiiotPrinter.printImage(bytes);
      } catch (e) {
        debugPrint(e.toString());
      }
      await MobiiotPrinter.lineWrap(1);
    //  await MobiiotPrinter.darkness(2);
      await MobiiotPrinter.printText("SERIKALI YA MAPINDUZI ZANZIBAR",style: {"bold": true,  "align": 1});
      await MobiiotPrinter.printText("(OR-TMSMIM) BARAZA LA MANISPAA",style: {"bold": true, "align": 1});
      await MobiiotPrinter.printText("Simu: +255716340430",style: { "font": 1, "align": 1});
      await MobiiotPrinter.printText("Email: mlandege.go.tz",style: { "font": 1, "align": 1});
      await MobiiotPrinter.lineWrap(1);
      await MobiiotPrinter.printText("STAKABADHI YA MALIPO",style: { "bold":true});
      await MobiiotPrinter.printText("Namba ya risit: 1233333");
      await MobiiotPrinter.printText("Jina la Mlipaji: 1233333");
      await MobiiotPrinter.printText("Malipo kwa Tarakimu: 1233333");
       await MobiiotPrinter.lineWrap(8);
      await MobiiotPrinter.unbindingPrinter();

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(child: Text("print"), onPressed: () => printReceipt(),)
        ),
      ),
    );
  }
}
