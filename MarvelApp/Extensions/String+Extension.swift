//
//  String+Extension.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import Foundation
import CryptoKit

extension String {
    
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    func generateImageURLString(path: String, extension: String) -> Self {
        let urlString = path + "." + `extension`
        
        return urlString
    }

}
