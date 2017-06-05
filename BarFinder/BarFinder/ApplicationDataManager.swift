//
//  ApplicationDataManager.swift
//  BarFinder
//
//  Created by Damien Laughton on 05/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation
import CoreLocation

public class ApplicationDataManager {

  private init() {
    NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: .LocationUpdated, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .LocationUpdated, object: .none)
  }
  
  var currentCoordinate: CLLocationCoordinate2D? = .none
  
  internal static let sharedInstance = ApplicationDataManager()
  
  var VM_latestBarInformation: [Bar] {
    let temp: [Bar] = self.processInformation(json: self.latestBarJson)
    return temp
  }
  
  private var latestBarJson: JSON = [:] {
    didSet {
      NotificationCenter.default.post(name: .BarsUpdated, object: self.VM_latestBarInformation)
    }
  }
  
  @objc private func locationUpdated(note: NSNotification) {
    guard let location = note.object as? CLLocation else { return }
    
    
    self.updateBars(coordinate: location.coordinate)
  }
  
  func updateBars(coordinate: CLLocationCoordinate2D?) {
    
    guard let _coordinate = coordinate else { return }
    
    if let _currentCoordinate = self.currentCoordinate {
      if _currentCoordinate.latitude == _coordinate.latitude && _currentCoordinate.longitude == _coordinate.longitude {
        return
      }
    }
    
    self.currentCoordinate = coordinate
    
    APIManagerSingleton.sharedInstance.performNearbySearch(location: _coordinate) { [unowned self] data, response, error in
      DispatchQueue.main.async {
        
        print("\(self)")
        let validStatusCode = response?.isValidStatusCode() ?? false
        
        if (nil != error) {
          //error clause
          print(error ?? "Unknown error")
        } else if (false == validStatusCode) {
          // invalid server status
        } else {
          //we're good
          
          guard let json = data?.json() else { return }
          print(json)
          self.latestBarJson = json
          
          
        }
      }
    }
  }
  
  private func processInformation(json: JSON) -> [Bar] {
    
    var bars: [Bar] = []
    
    if let results = json["results"] as? [JSON] {
      for resultItem in results {
        var name = ""
        if let _name = resultItem["name"] as? String {
          name = _name
        }
        var lat = 0.0
        var lon = 0.0
        var distance = 0.0
        
        if let geometry = resultItem["geometry"] as? JSON {
          if let location = geometry["location"] as? JSON {
            if let _lat = location["lat"] as? Double
            {
              lat = _lat
            }
            
            if let _lon = location["lng"] as? Double {
              lon = _lon
            }
            
            if (lat != 0 && lon != 0) {
              if let _distance = self.currentCoordinate?.distanceTo(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                distance = _distance
              }
            }
          }
        }
        
        let bar = Bar(barName: name, distance: "\(Int(distance))m", lat: lat, lon: lon)
        
        bars.append(bar)
        
      }
    }
    

    
    return bars
  }
  
}

