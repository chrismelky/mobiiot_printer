
import 'package:flutter/services.dart';

class MobiiotPrinter {

  static const MethodChannel _channel = MethodChannel("mobiiot_printer");

  static Future<bool?> bindingPrinter() async {
    final bool? status = await _channel.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  static Future<bool?> unbindingPrinter() async {
    final bool? status = await _channel.invokeMethod('UNBIND_PRINTER_SERVICE');
    return status;
  }

  static Future<void> printText(String text, {Map<String, dynamic>? style}) async {
    Map<String, dynamic> arguments = <String, dynamic>{"text": '$text'};
    if(style != null) {
      arguments.addAll(style);
    }
    await _channel.invokeMethod("PRINT_TEXT", arguments);
  }

  static Future<void> lineWrap(int lines) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": lines};
    await _channel.invokeMethod("LINE_WRAP", arguments);
  }
  
  static Future<void> printImage(Uint8List img) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent("bitmap", () => img);
    await _channel.invokeMethod("PRINT_IMAGE", arguments);
  }
  
  static Future<void> sync(bool sync) async {
    Map<String, dynamic> arguments = <String, dynamic>{"sync": sync};
    await _channel.invokeMethod("SET_SYNC", arguments);
  }
  
  static Future<void> darkness(int darkness) async {
    Map<String, dynamic> arguments = <String, dynamic>{"darkness": darkness};
    await _channel.invokeMethod("SET_DARKNESS", arguments);
  }

  static Future<void> setAlignment(int align) async {
    Map<String, dynamic> arguments = <String, dynamic>{"align": align};
    await _channel.invokeMethod("SET_ALIGNMENT", arguments);
  }
}
