import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_utils_platform_interface.dart';

/// An implementation of [GoogleMapUtilsPlatform] that uses method channels.
class MethodChannelGoogleMapUtils extends GoogleMapUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('google_map_utils');

  @override
  Future<LatLng> getGeometryOffset({
    required LatLng from,
    required double direction,
    required double distance,
  }) async {
    final List<dynamic> latLng =
        (await methodChannel.invokeMethod<List<dynamic>>('getGeometryOffset', {
      'latitude': from.latitude,
      'longitude': from.longitude,
      'distance': distance,
      'heading': direction,
    }))!;
    print(latLng);
    return LatLng(latLng[0] as double, latLng[1] as double);
  }
}
