import 'package:flutter_test/flutter_test.dart';
import 'package:google_map_utils/google_map_utils.dart';
import 'package:google_map_utils/google_map_utils_platform_interface.dart';
import 'package:google_map_utils/google_map_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGoogleMapUtilsPlatform
    with MockPlatformInterfaceMixin
    implements GoogleMapUtilsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GoogleMapUtilsPlatform initialPlatform = GoogleMapUtilsPlatform.instance;

  test('$MethodChannelGoogleMapUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGoogleMapUtils>());
  });

  test('getPlatformVersion', () async {
    GoogleMapUtils googleMapUtilsPlugin = GoogleMapUtils();
    MockGoogleMapUtilsPlatform fakePlatform = MockGoogleMapUtilsPlatform();
    GoogleMapUtilsPlatform.instance = fakePlatform;

    expect(await googleMapUtilsPlugin.getPlatformVersion(), '42');
  });
}
