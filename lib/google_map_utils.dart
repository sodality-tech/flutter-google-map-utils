
import 'google_map_utils_platform_interface.dart';

class GoogleMapUtils {
  Future<String?> getPlatformVersion() {
    return GoogleMapUtilsPlatform.instance.getPlatformVersion();
  }
}
