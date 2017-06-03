//
//  NearMeViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit
import GoogleMaps

class NearMeViewController : RootViewController, GMSMapViewDelegate {

  @IBOutlet weak var mapView: GMSMapView!
  private let CITY_ZOOM_LEVEL = Float(15)
  
  var bars: [Bar] = []
  
  internal let mockBars = [Bar(barName: "Joe's", distance: "250m", lat: 0, lon: 0), Bar(barName: "Mary's", distance: "350m", lat: 0, lon: 0)]

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    mapView.delegate = self
    mapView.isMyLocationEnabled = true
    
    
    let sydney = GMSCameraPosition.camera(withLatitude: -33.8683,
                                          longitude: 151.2086,
                                          zoom: CITY_ZOOM_LEVEL)
    mapView.camera = sydney
    
    if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
      mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
    }
    
    self.addMarkersToMap(bars: self.bars)
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
  
}
