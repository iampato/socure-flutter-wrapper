import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:socure/models/socure_error_result.dart';
import 'package:socure/models/socure_success_result.dart';
import 'package:socure/utils/callbacks.dart';

import 'socure_platform_interface.dart';

/// An implementation of [SocurePlatform] that uses method channels.
class MethodChannelSocure extends SocurePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('socure');

  @override
  Future<void> launchSocure({
    required String sdkKey,
    required OnSuccessCallback onSuccess,
    required OnErrorCallback onError,
    String? flow,
  }) async {
    final result = await methodChannel.invokeMethod<String>(
      'launchSocure',
      <String, dynamic>{
        'sdkKey': sdkKey,
        'flow': flow,
      },
    );
    // string to json
    if (result != null) {
      // print("####################");
      // print("##########$result##########");
      // print("####################");
      Map<String, dynamic> json = jsonDecode(result);
      // if json contains key docUUID then it is success
      if (json.containsKey('docUUID')) {
        // convert json to model
        final socureSuccessResult = SocureSuccessResult.fromJson(json);
        // call success callback
        onSuccess(socureSuccessResult);
      } else {
        // convert json to model
        final socureErrorResult = SocureErrorResult.fromJson(json);
        onError(socureErrorResult);
      }
    }
  }
}
