import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'google_map_utils_method_channel.dart';

abstract class GoogleMapUtilsPlatform extends PlatformInterface {
  /// Constructs a GoogleMapUtilsPlatform.
  GoogleMapUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleMapUtilsPlatform _instance = MethodChannelGoogleMapUtils();

  /// The default instance of [GoogleMapUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleMapUtils].
  static GoogleMapUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoogleMapUtilsPlatform] when
  /// they register themselves.
  static set instance(GoogleMapUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
