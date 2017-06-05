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
  
  internal static let sharedInstance = ApplicationDataManager()
  
  var VM_latestBarInformation: [Bar] {
    let temp: [Bar] = self.processInformation(json: self.latestBarJson)
    return temp
  }
  
  private var latestBarJson: JSON = [:] {
    didSet {
      NotificationCenter.default.post(name: .DataUpdated, object: self.VM_latestBarInformation)
    }
  }
  
  func updateBars(location: CLLocationCoordinate2D?) {
    
    guard let _location = location else { return }
    
    APIManagerSingleton.sharedInstance.performNearbySearch(location: _location) { [unowned self] data, response, error in
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
    
//    var lastForecastItem: Forecast = Forecast()
//    
//    if let list = weather["list"] as? [JSON] {
//      
//      
//      
//      for listItem in list {
//        
//        let timeInterval = listItem["dt"] as? TimeInterval ?? 0
//        let date = Date(timeIntervalSince1970: timeInterval)
//        var temperature = 0.0
//        if let main = listItem["main"] as? JSON {
//          if let _temperature = main["temp"] as? Double {
//            temperature = _temperature
//          }
//        }
//        var description = ""
//        if let weather = listItem["weather"] as? [JSON] {
//          if let _weatherZero = weather.first {
//            let _weatherMain = _weatherZero["main"] as? String ?? ""
//            let _weatherDescription = _weatherZero["description"] as? String ?? ""
//            description = "\(_weatherMain) (\(_weatherDescription))"
//          }
//        }
//        
//        if (lastForecastItem.isEmpty()) {
//          lastForecastItem.append(date: date, temperature: temperature, description: description)
//        } else if (lastForecastItem.isSameDate(date: date)) {
//          lastForecastItem.append(date: date, temperature: temperature, description: description)
//        } else {
//          forecast.append(lastForecastItem)
//          lastForecastItem = Forecast()
//          
//          lastForecastItem.append(date: date, temperature: temperature, description: description)
//        }
//        
//      }
//      
//      forecast.append(lastForecastItem)
//      
//    }
    
    return bars
  }
  
}

