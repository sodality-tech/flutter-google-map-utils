import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_utils_platform_interface.dart';

class GoogleMapUtils {
  Future<LatLng> getGeometryOffset({
    required LatLng from,
    required double direction,
    required double distance,
  }) {
    return GoogleMapUtilsPlatform.instance.getGeometryOffset(
        from: from, direction: direction, distance: distance);
  }
}
