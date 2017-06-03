//
//  LocationManagerSingleton.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation
import CoreLocation

//Constants
typealias AuthorizationCompletionHandler = (CLAuthorizationStatus) -> Void
typealias LocationReceivedCompletionHandler = (CLLocation/*, Bool, Double*/) -> Void

class LocationManagerSingleton: NSObject, CLLocationManagerDelegate {
  
  static let sharedInstance = LocationManagerSingleton()
  
  private var lastLocation: CLLocation? = .none
  
  private let DEFAULTS_IS_UPDATING = "isUpdating"
  private let DEFAULTS_HYBRID_TIMESTAMP = "hybridTimestamp"
//  private let NO_TIMESTAMP = -1.0
  
  //LocationManager settings
  //TODO Possibly being changed on the fly from the server
  private let activityType = CLActivityType.other
  private let desiredAccuracy = kCLLocationAccuracyBest
  private let distanceFilter = 10.0
  
  //Hybrid settings
  //TODO Possibly being changed on the fly from the server
//  private let hybridTimeoutInSeconds = 300.0
//  private let hybridSpeedThreshold = 10.0
  
//  private var isSignificantChange: Bool = false
  
  //User Defaults Variables
  private(set) var isUpdating: Bool { //This should persist the setting between app run times
    set(newValue) {
      
      UserDefaults.standard.set(newValue, forKey: DEFAULTS_IS_UPDATING)
      UserDefaults.standard.synchronize()
    }
    get { return UserDefaults.standard.bool(forKey: DEFAULTS_IS_UPDATING) }
  }
//  private(set) var hybridTimestamp: TimeInterval {
//    set(newValue) {
//      UserDefaults.standard.setValue(NSNumber(value: newValue), forKey: DEFAULTS_HYBRID_TIMESTAMP)
//      UserDefaults.standard.synchronize()
//    }
//    get { return (UserDefaults.standard.object(forKey: DEFAULTS_HYBRID_TIMESTAMP) as? NSNumber)?.doubleValue ?? NO_TIMESTAMP }
//  }
  
  //Members
  private var locationManager:CLLocationManager? = .none
  var onAuthorizationComplete: AuthorizationCompletionHandler? = nil
  var onLocationReceived: LocationReceivedCompletionHandler? = nil
  
  
  private override init() {
    super.init()
    
    DispatchQueue.main.async {
      self.locationManager = CLLocationManager()
      self.locationManager?.delegate = self
      self.locationManager?.activityType = self.activityType
      self.locationManager?.desiredAccuracy = self.desiredAccuracy
      self.locationManager?.distanceFilter = self.distanceFilter
      self.locationManager?.allowsBackgroundLocationUpdates = true
      self.locationManager?.pausesLocationUpdatesAutomatically = false
    }
    
  }
  
  func authorize() {
    DispatchQueue.main.async {
      self.locationManager?.requestAlwaysAuthorization()
    }
  }
  
  func start() {
    
    if (CLLocationManager.authorizationStatus() == .authorizedAlways) {
      
//      hybridTimestamp = NO_TIMESTAMP
      isUpdating = true
      locationManager?.startUpdatingLocation()
      locationManager?.startMonitoringSignificantLocationChanges()
    }
  }
  
  func stop() {
    
//    hybridTimestamp = NO_TIMESTAMP
    isUpdating = false
    locationManager?.stopUpdatingLocation()
    locationManager?.stopMonitoringSignificantLocationChanges()
  }
  
//  func handleHybridMode(currentSpeed: CLLocationSpeed) {
//    
//    let readOnlyHybridTimestamp = hybridTimestamp //Stop getting from user defaults multiple times
//    let hybridTimestampSeconds = Date().timeIntervalSince(Date(timeIntervalSince1970: readOnlyHybridTimestamp))
//    
//    self.isSignificantChange = false
//    
//    if (readOnlyHybridTimestamp == NO_TIMESTAMP) {
//      
//      hybridTimestamp = Date().timeIntervalSince1970
//      self.isSignificantChange = true
//      locationManager?.startUpdatingLocation()
//    }
//    else if (hybridTimestampSeconds > hybridTimeoutInSeconds) {
//      
//      hybridTimestamp = NO_TIMESTAMP
//      locationManager?.stopUpdatingLocation()
//    }
//    else if (currentSpeed > hybridSpeedThreshold) {
//      
//      hybridTimestamp = Date().timeIntervalSince1970
//    }
//  }
  
//  private func calculateSpeed(firstLocation: CLLocation, secondLocation: CLLocation) -> Double {
//    var calculatedSpeed: Double = 0
//    
//    let distance = firstLocation.distance(from: secondLocation)
//    let firstTime = firstLocation.timestamp
//    let secondTime = secondLocation.timestamp
//    
//    let time = secondTime.timeIntervalSince(firstTime)
//    
//    if time > 0.0 {
//      calculatedSpeed = distance / time
//    }
//    
//    return calculatedSpeed
//  }
  
  //MARK:- CLLocationManagerDelegate
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.first else { return }
    
//    var calculatedSpeed: Double = 0
//    
//    if let lastLocation = self.lastLocation {
//      calculatedSpeed = self.calculateSpeed(firstLocation: lastLocation, secondLocation: location)
//    }
//    self.lastLocation = location
//    
//    var currentSpeed = calculatedSpeed != 0 ? calculatedSpeed : location.speed
//    if currentSpeed < 0 {
//      currentSpeed = 0
//    }
//    
//    handleHybridMode(currentSpeed: currentSpeed)
    
    if let locationHandler = onLocationReceived {
      
      locationHandler(location /*, self.isSignificantChange, calculatedSpeed*/)
    }
  }
  
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
  }
  
  public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    if let completionHandler = onAuthorizationComplete {
      
      completionHandler(status)
    }
  }
}
