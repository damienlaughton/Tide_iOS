//
//  Data+JSON.swift
//  BarFinder
//
//  Created by Damien Laughton on 04/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation

extension Data {
  
  func json () -> JSON? {
    var json: JSON?
    
    do {
      if let _json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? JSON {
        json = _json
      }
    } catch {
      //Do Nothing
      print("json error: \(error)")
    }
    
    return json
  }
  
  func jsonArray () -> [JSON]? {
    var json: [JSON]?
    do {
      if let _json = try JSONSerialization.jsonObject(with: self) as? [JSON] {
        json = _json
      }
    } catch {
      //Do Nothing
    }
    
    return json
  }
}
