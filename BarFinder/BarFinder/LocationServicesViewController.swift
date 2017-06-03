//
//  LocationServicesViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit
import Foundation

class LocationServicesViewController: RootViewController {
  
  @IBAction func handleTurnOnLocationServices(button: UIButton) {
    
    if LocationManagerSingleton.sharedInstance.isAuthorizedNotDetermined() {
      self.askForLocationServices()
    } else {
      if let url = URL(string: UIApplicationOpenSettingsURLString) {
        UIApplication.shared.open(url, completionHandler: .none)
      }
    }
  }
  
  func askForLocationServices() {
    
    LocationManagerSingleton.sharedInstance.onAuthorizationComplete = { status in
      DispatchQueue.main.async {
        if (status == .authorizedAlways) {
          LocationManagerSingleton.sharedInstance.start()
//          TODO:Dismiss
        }
      }
    }
    
    LocationManagerSingleton.sharedInstance.onLocationReceived = { location in
      
      //TODO - Do Something with Location

    }
    
    if LocationManagerSingleton.sharedInstance.isAuthorizedToStart() {
      
      LocationManagerSingleton.sharedInstance.start()
      

    }
    else if LocationManagerSingleton.sharedInstance.isAuthorizedNotDetermined() {
      
      LocationManagerSingleton.sharedInstance.authorize()
//          TODO:Dismiss

    }
    else {
      
      //TODO: Handle awkwardness
    }
  }

}

