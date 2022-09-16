//
//  Connectivity.swift
//  TottersTest
//
//  Created by Mhd Baher on 14/09/2022.
//

import Foundation
import Reachability
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
