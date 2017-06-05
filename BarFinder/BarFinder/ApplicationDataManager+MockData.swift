//
//  ApplicationDataManager+MockData.swift
//  BarFinder
//
//  Created by Damien Laughton on 05/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation
import CoreLocation

extension ApplicationDataManager {
  var mockBars: [Bar] {
    return [Bar(barName: "Swan with Two Nicks", distance: "75m", lat: 52.225522, lon: -0.543225), Bar(barName: "The Fordham Arms", distance: "600m", lat: 52.224673, lon: -0.534498)]
  }
  
  var mockCurrentLocation: CLLocationCoordinate2D {
      return CLLocationCoordinate2D(latitude: 52.224094, longitude: -0.540816)
  }
}
