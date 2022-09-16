//
//  URL+Extension.swift
//  MarvelApp
//
//  Created by Mhd Baher on 16/09/2022.
//

import Foundation
import Alamofire

extension URL {
    
    func getData(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: self, completionHandler: completion).resume()
    }

}
