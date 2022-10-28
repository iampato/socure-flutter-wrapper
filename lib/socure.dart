import 'package:socure/models/socure_error_result.dart';
import 'package:socure/models/socure_success_result.dart';

import 'socure_platform_interface.dart';

class Socure {
  Future<void> launchSocure({
    required String sdkKey,
    String? flow,
    Function(SocureSuccessResult)? onSuccess,
    Function(SocureErrorResult)? onError,
  }) {
    return SocurePlatform.instance.launchSocure(sdkKey: sdkKey, flow: flow);
  }
}
