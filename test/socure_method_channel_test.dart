import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socure/socure_method_channel.dart';

void main() {
  MethodChannelSocure platform = MethodChannelSocure();
  const MethodChannel channel = MethodChannel('socure');

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
