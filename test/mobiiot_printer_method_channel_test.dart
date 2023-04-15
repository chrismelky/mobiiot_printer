import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiiot_printer/mobiiot_printer_method_channel.dart';

void main() {
  MethodChannelMobiiotPrinter platform = MethodChannelMobiiotPrinter();
  const MethodChannel channel = MethodChannel('mobiiot_printer');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
