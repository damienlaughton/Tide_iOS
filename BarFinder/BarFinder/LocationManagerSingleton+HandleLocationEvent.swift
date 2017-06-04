//
//  LocationManagerSingleton+HandleLocationEvent.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation
import CoreLocation

extension LocationManagerSingleton {

  static let defaultOnLocationHandler: LocationReceivedCompletionHandler = { location in
    
    NotificationCenter.default.post(name: .LocationUpdated, object: location)
    
  }

}
