import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'google_map_utils_platform_interface.dart';

/// An implementation of [GoogleMapUtilsPlatform] that uses method channels.
class MethodChannelGoogleMapUtils extends GoogleMapUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('google_map_utils');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
