//
//  APIManagerSingleton.swift
//  BarFinder
//
//  Created by Damien Laughton on 04/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation

public class APIManagerSingleton {
  
  static let sharedInstance = APIManagerSingleton()
  
  internal var URLNearbySearch: String { return "https://maps.googleapis.com/maps/api/place/nearbysearch/" }
  
  private init() {
  }
  
  deinit {
  }
  
  internal func performRequest(url: String, httpMethod: String, httpBodyParameters: JSON? = .none, headerParameters: JSON? = .none, completion: @escaping APICompletionHandler) {
    
    let urlWithExtraParameters = "\(url)&key=\(GOOGLE_API_KEY)"
    
    guard let requestURL = URL(string: urlWithExtraParameters) else { return }
    
    var mutableRequest = URLRequest(url: requestURL)
    mutableRequest.httpMethod = httpMethod
    mutableRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let params = httpBodyParameters, let jsonData = try? JSONSerialization.data(withJSONObject: params) {
      
      mutableRequest.httpBody = jsonData
    }
    
    if let headers = headerParameters {
      for (key, _value) in headers {
        if let value = _value as? String {
          mutableRequest.setValue(value, forHTTPHeaderField: key)
        }
        
      }
    }
    
    URLSession.shared.dataTask(with: mutableRequest, completionHandler: completion).resume()
  }
  
  
  
}
