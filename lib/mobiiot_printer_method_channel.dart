import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobiiot_printer_platform_interface.dart';

/// An implementation of [MobiiotPrinterPlatform] that uses method channels.
class MethodChannelMobiiotPrinter extends MobiiotPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobiiot_printer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
