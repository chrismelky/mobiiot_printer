import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobiiot_printer_method_channel.dart';

abstract class MobiiotPrinterPlatform extends PlatformInterface {
  /// Constructs a MobiiotPrinterPlatform.
  MobiiotPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobiiotPrinterPlatform _instance = MethodChannelMobiiotPrinter();

  /// The default instance of [MobiiotPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobiiotPrinter].
  static MobiiotPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobiiotPrinterPlatform] when
  /// they register themselves.
  static set instance(MobiiotPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
