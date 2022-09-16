//
//  ApiManager.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: BaseRequestManager {
    
    static let shared = ApiManager()
    
    private override init() {}
}
