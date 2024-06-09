import Flutter
import UIKit

import GoogleMaps

public class GoogleMapUtilsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "google_map_utils", binaryMessenger: registrar.messenger())
    let instance = GoogleMapUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getGeometryOffset":
        guard let args = call.arguments as? [String: Any],
              let latitude = args["latitude"] as? Double,
              let longitude = args["longitude"] as? Double,
              let distance = args["distance"] as? Double,
              let heading = args["heading"] as? Double
        else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for getGeometryOffset", details: nil))
            return
      }
        
              // Print statement to log the received arguments
      print("Received arguments - Latitude: \(latitude), Longitude: \(longitude), Distance: \(distance), Heading: \(heading)")
              
        let offsetLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude).offset(distance: distance, heading:heading);
      result([offsetLocation.latitude, offsetLocation.longitude])
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
