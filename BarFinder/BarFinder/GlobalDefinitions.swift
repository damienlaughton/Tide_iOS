//
//  GlobalDefinitions.swift
//  BarFinder
//
//  Created by Damien Laughton on 03/06/2017.
//  Copyright © 2017 Mobilology Limited. All rights reserved.
//

import Foundation

typealias APICompletionHandler = (Data?, URLResponse?, Error?) -> ()
typealias AnimationCompletionHandler = (Bool) -> ()
typealias VoidCompletionHandler = () -> ()

typealias JSON = [String: Any]

let GOOGLE_API_KEY = "AIzaSyB6AvJCuawPc99PY9CfC6nKVc84IkZ_PhE"
