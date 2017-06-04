//
//  LocationManagerSingleton.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation
import CoreLocation

typealias AuthorizationCompletionHandler = (CLAuthorizationStatus) -> Void
typealias LocationReceivedCompletionHandler = (CLLocation/*, Bool, Double*/) -> Void

class LocationManagerSingleton: NSObject, CLLocationManagerDelegate {
  
  static let sharedInstance = LocationManagerSingleton()
  
  private let activityType = CLActivityType.otherNavigation
  private let desiredAccuracy = kCLLocationAccuracyBest
  private let distanceFilter = 1.0
  
  //User Defaults Variables
  private let DEFAULTS_IS_UPDATING = "isUpdating"
  private let DEFAULTS_HYBRID_TIMESTAMP = "hybridTimestamp"
  private(set) var isUpdating: Bool { //This should persist the setting between app run times
    set(newValue) {
      
      UserDefaults.standard.set(newValue, forKey: DEFAULTS_IS_UPDATING)
      UserDefaults.standard.synchronize()
    }
    get { return UserDefaults.standard.bool(forKey: DEFAULTS_IS_UPDATING) }
  }
  
  //Members
  private var locationManager:CLLocationManager? = .none
  var onAuthorizationComplete: AuthorizationCompletionHandler? = .none
  var onLocationReceived: LocationReceivedCompletionHandler? = .none
  var lastLocation: CLLocation? = .none  
  
  private override init() {
    super.init()
    
    DispatchQueue.main.async {
      self.locationManager = CLLocationManager()
      self.locationManager?.delegate = self
      self.locationManager?.activityType = self.activityType
      self.locationManager?.desiredAccuracy = self.desiredAccuracy
      self.locationManager?.distanceFilter = self.distanceFilter
      self.locationManager?.allowsBackgroundLocationUpdates = false
      self.locationManager?.pausesLocationUpdatesAutomatically = false
    }
    
  }
  
  func authorize() {
    DispatchQueue.main.async {
      self.locationManager?.requestWhenInUseAuthorization()
    }
  }
  
  func start() {
    if (CLLocationManager.authorizationStatus() == .authorizedAlways) {
      isUpdating = true
      locationManager?.startUpdatingLocation()
      locationManager?.startMonitoringSignificantLocationChanges()
    }
  }
  
  func stop() {
    isUpdating = false
    locationManager?.stopUpdatingLocation()
    locationManager?.stopMonitoringSignificantLocationChanges()
  }
  
  //MARK:- CLLocationManagerDelegate
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.first else { return }
    
    self.lastLocation = location
    
    if let locationHandler = onLocationReceived {
      locationHandler(location)
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
