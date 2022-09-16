//
//  ApiManager.swift
//  MarvelApp
//
//  Created by Mhd Baher on 15/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: BaseRequestManager {
    
    static let shared = ApiManager()
    
    private override init() {}
}
