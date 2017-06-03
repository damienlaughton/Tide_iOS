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
  
  var bars: [Bar] = []
  var startLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.224094, longitude: -0.540816)
  
  internal let mockBars = [Bar(barName: "Swan with Two Nicks", distance: "75m", lat: 52.225522, lon: -0.543225), Bar(barName: "The Fordham Arms", distance: "600m", lat: 52.224673, lon: -0.534498)]
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
      mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.removeMask(animated: true, completionHandler: { _ in
    

      self.zoomToLocation(location: self.startLocation)
      
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

  }
  
  private func zoomToLocation(location: CLLocationCoordinate2D) {
    let sydney = GMSCameraPosition.camera(withLatitude: location.latitude,
                                          longitude: location.longitude,
                                          zoom: self.CITY_ZOOM_LEVEL)
    self.mapView.camera = sydney
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

  
}
