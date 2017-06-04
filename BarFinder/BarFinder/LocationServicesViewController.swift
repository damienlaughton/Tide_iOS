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

  deinit {
    NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: .none)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: .none)
  }
  
  @objc func applicationDidBecomeActive() {
    if LocationManagerSingleton.sharedInstance.isAuthorizedToStart() {
      LocationManagerSingleton.sharedInstance.start()
      self.dismiss(animated: true, completion: .none)
    }
  }
  
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
          self.dismiss(animated: true, completion: .none)
        }
      }
    }
    
    LocationManagerSingleton.sharedInstance.onLocationReceived = LocationManagerSingleton.defaultOnLocationHandler
    
    
    if LocationManagerSingleton.sharedInstance.isAuthorizedToStart() {
      LocationManagerSingleton.sharedInstance.start()
    }
    else if LocationManagerSingleton.sharedInstance.isAuthorizedNotDetermined() {
      LocationManagerSingleton.sharedInstance.authorize()
    }
    else {
      //TODO: Handle awkwardness
    }
  }

}

