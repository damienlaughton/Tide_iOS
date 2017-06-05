//
//  CLLocationCoordinate2D+Distance.swift
//  BarFinder
//
//  Created by Damien Laughton on 05/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

// Originally Dave Wood - https://stackoverflow.com/a/35551590/741626

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
  func distanceTo(coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
    let thisLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
    let otherLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    return thisLocation.distance(from: otherLocation)
  }
}
