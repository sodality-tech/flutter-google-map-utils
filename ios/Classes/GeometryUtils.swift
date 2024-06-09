//
//  GeometryUtils.swift
//  google_map_utils
//
//  Created by Harinandan R Nair on 07/06/24.
//

import GoogleMaps

public extension CLLocationCoordinate2D {
    func offset(distance: CLLocationDistance, heading: CLLocationDistance) -> CLLocationCoordinate2D {
        return offset(distance: distance, heading: heading, radius: kGMSEarthRadius)
    }
}

private extension CLLocationCoordinate2D {
  /// Returns the great circle distance between this coordinate and `to` on a sphere with radius `radius` in meters.
  ///
  /// - Parameters:
  ///   - to: The CLLocationCoordinate2D to compute the distance from
  ///   - radius: The radius in meters
  /// - Returns: The great circle distance
  func distance(to: CLLocationCoordinate2D, radius: CLLocationDistance) -> CLLocationDistance {
    return radius * distanceUnit(to: to)
  }

  /// Returns the distance between this coordinate and `to` on the unit sphere.
  /// - Parameters:
  ///   - to: The CLLocationCoordinate2D to compute the distance from
  /// - Returns: The great circle distance on a unit sphere
  func distanceUnit(to: CLLocationCoordinate2D) -> CLLocationDistance {
      return Math.inverseHaversine(Math.haversineDistance(self.latLngRadians, to.latLngRadians))
  }

  /// Returns the destination coordinate, when starting from this coordinate with initial `heading`, travelling `distance` meters along a great circle arc
  /// on a sphere with radius `radius`.
  ///
  /// - Parameters:
  ///   - distance: The distance to offset by from this coordinate
  ///   - heading: The inital heading to offset by from this coordinate
  ///   - radius: The radius of the sphere
  /// - Returns: The destination coordinate
  func offset(
    distance: CLLocationDistance,
    heading: CLLocationDistance,
    radius: CLLocationDistance
  ) -> CLLocationCoordinate2D {
    let angularDistance = distance / radius
    return offsetUnit(angularDistance: angularDistance, heading: heading)
  }

  /// Offset this coordinate by the provided `angularDistance` and `heading` on a unit sphere
  ///
  /// - Parameters:
  ///   - angularDistance: The angular distance on a unit sphere
  ///   - heading: The inital heading to offset by from this coordinate
  /// - Returns: The destination coordinate
  func offsetUnit(angularDistance: Double, heading: CLLocationDistance) -> CLLocationCoordinate2D {
    let bearing = heading.radians
    let latLng1 = self.latLngRadians
    let sinLat2 = sin(latLng1.latitude) * cos(angularDistance) + cos(latLng1.latitude) * sin(angularDistance) * cos(bearing)
    let lat2 = asin(sinLat2)
    let y = sin(bearing) * sin(angularDistance) * cos(latLng1.latitude)
    let x = cos(angularDistance) - sin(latLng1.latitude) * sinLat2
    let lng2 = latLng1.longitude + atan2(y, x)
    return CLLocationCoordinate2D(
      latitude: lat2.degrees,
      longitude: Math.wrap(value: lng2.degrees, min: -180, max: 180)
    )
  }
}

