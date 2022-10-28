import 'package:flutter_test/flutter_test.dart';
import 'package:socure/socure.dart';
import 'package:socure/socure_platform_interface.dart';
import 'package:socure/socure_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSocurePlatform
    with MockPlatformInterfaceMixin
    implements SocurePlatform {
  @override
  Future<Map<String, dynamic>?> launchSocure(
      {required String sdkKey, String? flow}) {
    return Future.value({"docUUID": "sample"});
  }
}

void main() {
  final SocurePlatform initialPlatform = SocurePlatform.instance;

  test('$MethodChannelSocure is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSocure>());
  });

  test('launchSocure', () async {
    Socure socurePlugin = Socure();
    MockSocurePlatform fakePlatform = MockSocurePlatform();
    SocurePlatform.instance = fakePlatform;

    expect(await socurePlugin.launchSocure(sdkKey: ""), null);
  });
}
