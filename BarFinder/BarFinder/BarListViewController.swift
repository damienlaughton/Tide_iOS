//
//  BarListViewController.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import UIKit

@IBDesignable class BarListViewController : RootViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView?

  var bars: [Bar] = ApplicationDataManager.sharedInstance.VM_latestBarInformation
  let mockBars = ApplicationDataManager.sharedInstance.mockBars
  
  internal let cellIdentifier = String(describing: UIBarListTableViewCell.self)
  
  override func configure() {
    super.configure()
    
    self.tableView?.backgroundColor = UIColor.barViewBackground()
    
    self.tableView?.register(UINib(nibName: self.cellIdentifier, bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .BarsUpdated, object: .none)
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    NotificationCenter.default.addObserver(self, selector: #selector(updateBars), name: .BarsUpdated, object: nil)
  }
  
  @objc private func updateBars(note: NSNotification) {
    guard let bars = note.object as? [Bar] else { return }
    
    self.bars = bars
    self.tableView?.reloadData()
  }
  
  func bar(indexPath: IndexPath) -> Bar {
  
    var barsForIndexPath = self.bars
    
    if (barsForIndexPath.count == 0) {
      barsForIndexPath = self.mockBars
    }
    
    let barForIndexPath = barsForIndexPath[indexPath.row]
    
    return barForIndexPath
  }
  
//  MARK:- TableView Delegate / DataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UIBarListTableViewCell()

    if let _cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? UIBarListTableViewCell {
      
      _cell.configure(bar: self.bar(indexPath: indexPath))
      
      cell = _cell
    }
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRowsInSection = 0
    
    if (self.bars.count > 0) {
      numberOfRowsInSection = self.bars.count
    } else {
      numberOfRowsInSection = self.mockBars.count
    }
  
    return numberOfRowsInSection
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    let bar = self.bar(indexPath: indexPath)
  
    if let url = URL(string:"comgooglemaps://?center=\(bar.lat),\(bar.lon)&zoom=\(GOOGLE_ZOOM_LEVEL)&views=traffic") {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //If you want handle the completion block than
        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
          print("Open url : \(success)")
        })
      } else {
        if let webURL = URL(string:"https://www.google.com/maps/preview/@\(bar.lat),\(bar.lon),\(GOOGLE_ZOOM_LEVEL)z") {
        
          if UIApplication.shared.canOpenURL(webURL) {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
              print("Open webURL : \(success)")
            })
          } else {
            // Do Nothing
          }
        }
      }
    }
  


  }
  
}
