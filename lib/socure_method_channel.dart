import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'socure_platform_interface.dart';

/// An implementation of [SocurePlatform] that uses method channels.
class MethodChannelSocure extends SocurePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('socure');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Map<String, dynamic>?> launchSocure({required String sdkKey, String? flow}) async {
   final result = await methodChannel.invokeMethod<Map<String, dynamic>>(
      'launchSocure',
      <String, dynamic>{
        'sdkKey': sdkKey,
        'flow': flow,
      },
    );
   return result;
  }
}
