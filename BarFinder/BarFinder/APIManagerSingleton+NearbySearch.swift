//
//  APIManagerSingleton+NearbySearch.swift
//  BarFinder
//
//  Created by Damien Laughton on 04/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import CoreLocation

extension APIManagerSingleton {
  
  func performNearbySearch(location: String, output: String = "json", type: String = "bar", radius:String = "500", httpBodyParameters: JSON? = .none, headerParameters: JSON? = .none, completion: @escaping APICompletionHandler) {
    
    let url = "\(URLNearbySearch)\(output)?location=\(location)&radius=\(radius)&type=\(type)"
    
    self.performRequest(url: url, httpMethod: "GET", completion: completion)
    
  }
  
  func performNearbySearch(location: CLLocationCoordinate2D, output: String = "json", type: String = "bar", radius:String = "500", httpBodyParameters: JSON? = .none, headerParameters: JSON? = .none, completion: @escaping APICompletionHandler) {
  
    let locationFromCLLocationCoordinate2D = "\(location.latitude),\(location.longitude)"
    
    let url = "\(URLNearbySearch)\(output)?location=\(locationFromCLLocationCoordinate2D)&radius=\(radius)&type=\(type)"
    
    self.performRequest(url: url, httpMethod: "GET", completion: completion)
    
  }
  
}
