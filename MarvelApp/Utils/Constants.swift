//
//  Constants.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import Foundation
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct Constants {
    static let shared = Constants()
    
    private init() {}

    let serverURL = "https://gateway.marvel.com:443/v1/public"
    let apiPublicKey = "caba15b3ce5243c0f563b7049aa8b881"
    let apiPrivateKey = "dc8469594b13b56c7913e203ee57d8422011d2f0"
    
    var timeStamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    var md5String: String {
        get {
            let hashString = timeStamp + apiPrivateKey + apiPublicKey
            
            return hashString.md5
        }
    }

}
