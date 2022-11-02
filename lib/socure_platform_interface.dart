import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:socure/utils/callbacks.dart';

import 'socure_method_channel.dart';

abstract class SocurePlatform extends PlatformInterface {
  /// Constructs a SocurePlatform.
  SocurePlatform() : super(token: _token);

  static final Object _token = Object();

  static SocurePlatform _instance = MethodChannelSocure();

  /// The default instance of [SocurePlatform] to use.
  ///
  /// Defaults to [MethodChannelSocure].
  static SocurePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SocurePlatform] when
  /// they register themselves.
  static set instance(SocurePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> launchSocure({
    required String sdkKey,
    required OnSuccessCallback onSuccess,
    required OnErrorCallback onError,
    String? flow,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
