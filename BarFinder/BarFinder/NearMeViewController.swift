//
//  NearMeViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class NearMeViewController : RootViewController, GMSMapViewDelegate {

  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var maskView: UIView!
  private let CITY_ZOOM_LEVEL = Float(15)
  
  @IBOutlet weak var debugLabel: UILabel?
  
  var bars: [Bar] = []
  var mockLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.224094, longitude: -0.540816)
  var currentLocation: CLLocationCoordinate2D? = .none
  
  internal let mockBars = [Bar(barName: "Swan with Two Nicks", distance: "75m", lat: 52.225522, lon: -0.543225), Bar(barName: "The Fordham Arms", distance: "600m", lat: 52.224673, lon: -0.534498)]
  
  
  deinit {
        NotificationCenter.default.removeObserver(self, name: .LocationUpdated, object: .none)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
      mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.removeMask(animated: true, completionHandler: { _ in

      self.zoomToCurrentLocation()
      
      if (self.bars.count > 0) {
        self.addMarkersToMap(bars: self.bars)
      } else {
        self.addMarkersToMap(bars: self.mockBars)
      }
    
    })
  }

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    mapView.delegate = self
    mapView.isMyLocationEnabled = true
    
    NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: .LocationUpdated, object: nil)
  }
  
  @objc private func locationUpdated(note: NSNotification) {
    guard let location = note.object as? CLLocation else { return }
    
    let debugText = "lon: \(location.coordinate.longitude) - lat:\(location.coordinate.latitude)"
    print("****\(debugText)")
    self.debugLabel?.text = debugText

    
//    if (self.currentLocation == nil) {
      self.zoomToLocation(location: location.coordinate)
//    }
    
    self.currentLocation = location.coordinate
//  TODO set current location
  }
  
  private func zoomToCurrentLocation() {
    let location = self.currentLocation ?? self.mockLocation

    self.zoomToLocation(location: location)
  }
  
  private func zoomToLocation(location: CLLocationCoordinate2D) {
    let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                          longitude: location.longitude,
                                          zoom: self.CITY_ZOOM_LEVEL)
    self.mapView.camera = camera
  }
  
  private func addMarkersToMap(bars: [Bar]) {
    
    mapView.clear()
    bars.forEach(addMarkerToMap)
  }
  
  private func addMarkerToMap(bar: Bar) {
    
    let marker = GMSMarker(position: CLLocationCoordinate2DMake(bar.lat, bar.lon))
    marker.icon = UIImage(named: "bar_map_pin")
    marker.title = bar.barName
    marker.map = mapView
  }
  
  //MARK:- GMSMapViewDelegate
  public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    
    return false
  }
  
  //  MARK:- Animation(s)
  
  func removeMask(animated: Bool = true, completionHandler: @escaping AnimationCompletionHandler = { _ in }) {
    
    guard let maskView = self.maskView else { return }
    
    if (!animated) {
      maskView.alpha = 0.0
      completionHandler(true)
      return
    }
    
    UIView.animate(withDuration:1.5, delay: 0.0, options: .curveEaseInOut,
                   animations: {
                    maskView.alpha = 0.0
    },
                   completion: { finished in
                    completionHandler(true)
    })
    
  }
  
  //MARK:- IBAction(s)
  
  @IBAction func arrowTapped(_ sender: UIButton) {
    self.zoomToCurrentLocation()
  }
  

  
}
