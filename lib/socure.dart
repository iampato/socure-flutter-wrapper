import 'package:socure/utils/callbacks.dart';

import 'socure_platform_interface.dart';

class Socure {
  // final OnSuccessCallbak
  Future<void> launchSocure({
    required String sdkKey,
    required OnSuccessCallback onSuccess,
    required OnErrorCallback onError,
    String? flow,
  }) {
    return SocurePlatform.instance.launchSocure(
      sdkKey: sdkKey,
      onSuccess: onSuccess,
      onError: onError,
      flow: flow,
    );
  }
}
