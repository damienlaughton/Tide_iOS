//
//  URLResponse+isValidStatusCode.swift
//  BarFinder
//
//  Created by Damien Laughton on 04/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

// Originally by Terence Baker - https://www.linkedin.com/in/terence-baker-91b18294/

import Foundation

extension URLResponse {
  
  func isValidStatusCode() -> Bool {
    
    if let httpResponse = self as? HTTPURLResponse {
      
      return ((200..<300) ~= httpResponse.statusCode)
    }
    else {
      
      return false
    }
  }
}

