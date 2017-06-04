//
//  LocationManagerSingleton+Authorization.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation
import CoreLocation

extension LocationManagerSingleton {
  func applicationAuthorizationStatus () -> CLAuthorizationStatus {
    return CLLocationManager.authorizationStatus()
  }
  
  func isAuthorizedToStart () -> Bool {
    let isAuthorizedToStart = self.locationServicesEnabled() && self.locationServicesEnabledWhenInUse()
    
    return isAuthorizedToStart
  }
  
  func locationServicesEnabled () -> Bool {
    return CLLocationManager.locationServicesEnabled()
  }
  
  func isAuthorizedDenied () -> Bool {
    return CLLocationManager.authorizationStatus() == .denied
  }
  
  func isAuthorizedNotDetermined () -> Bool {
    return CLLocationManager.authorizationStatus() == .notDetermined
  }
  
  func locationServicesEnabledWhenInUse () -> Bool {
    return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
  }
  
  func locationServicesEnabledAlways () -> Bool {
    return CLLocationManager.authorizationStatus() == .authorizedAlways
  }
  
}

