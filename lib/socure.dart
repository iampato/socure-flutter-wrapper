import 'socure_platform_interface.dart';

class Socure {
  Future<Map<String, dynamic>?> launchSocure({required String sdkKey, String? flow}) {
    return SocurePlatform.instance.launchSocure(sdkKey: sdkKey, flow: flow);
  }
}
