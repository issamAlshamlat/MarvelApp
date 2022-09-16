//
//  BaseRequestManager.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation
import Alamofire

typealias RequestResult = (_ success: Bool, _ responseObject: AnyObject?, _ error: NSError?) -> ()

class BaseRequestManager: NSObject {
    
    static let serverURL = Constants.shared.serverURL
    static let apiKey = Constants.shared.apiPublicKey
    static let hashString = Constants.shared.md5String
    static let timeStampString = Constants.shared.timeStamp
    
    static func endpoint( _ endpoint: Endpoint, offset: String?) -> URLConvertible
    {
        let fullURLString = serverURL + endpoint.rawValue
        
        var url = generateUrlQuery(fromURL: fullURLString)
        
        if let offset = offset {
            if offset != "0" {
                url.queryItems?.append(URLQueryItem (name: "offset", value: offset))
            }
        }

        do {
            let regex = try NSRegularExpression(pattern: "( )*$", options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, fullURLString.count)
            return regex.stringByReplacingMatches(in: "\(url)", options: [], range: range, withTemplate: "") as URLConvertible
        } catch {
            return url as URLConvertible
        }
    }
    
    static func endpoint(_ endpoint: Endpoint, resource: Int) -> URLConvertible
    {
        let fullURLString = serverURL + String(format: endpoint.rawValue, "\(resource)")
        
        var url = generateUrlQuery(fromURL: fullURLString)
        
        do {
            let regex = try NSRegularExpression(pattern: "( )*$", options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, fullURLString.count)
            return regex.stringByReplacingMatches(in: "\(url)", options: [], range: range, withTemplate: "") as URLConvertible
        } catch {
            return fullURLString as URLConvertible
        }
    }
    
    static func generateUrlQuery(fromURL url: String) -> URLComponents {
        var url = URLComponents(string: url)!
        url.queryItems = []
        
        url.queryItems?.append(URLQueryItem (name: "apikey", value: apiKey))
        url.queryItems?.append(URLQueryItem (name: "hash", value: hashString))
        url.queryItems?.append(URLQueryItem (name: "ts", value: timeStampString))
        
        return url
        
    }
    
    static func resolveRelativeURL(_ endpoint: String) -> URLConvertible
    {
        
        let fullURLString = serverURL + endpoint
        
        do {
            let regex = try NSRegularExpression(pattern: "( )*$", options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, fullURLString.count)
            return regex.stringByReplacingMatches(in: fullURLString, options: [], range: range, withTemplate: "") as URLConvertible
        } catch {
            return fullURLString as URLConvertible
        }
    }
    
    static func defaultResponseAction(_ response: DataResponse<Any>, completionHandler: RequestResult?)
    {
        debugPrint("BingOoOoOo", response)
        
        if completionHandler != nil
        {
            let statusCode = response.response?.statusCode
            if let code = statusCode
            {
                completionHandler!(code >= 200 && code < 300, response.result.value as AnyObject, response.result.error as NSError?)
            }
            else
            {
                completionHandler!(false, response.result.value as AnyObject, response.result.error as NSError?)
            }
        }
        self.handleErrors( response.response, error: response.result.error as NSError?)
    }
    
    static func handleErrors(_ response: HTTPURLResponse?, error: NSError?)
    {
        var statusCode: Int = 0
        if response != nil
        {
            statusCode = response!.statusCode
        }
        
        if statusCode == 500
        {
            return
        }
        
        if statusCode < 200 || statusCode >= 300
        {
            print("Error:\n\(String(describing: error))")
            
            var errorMessage: String

            if statusCode == 0 {
                return
            }
            
            if error != nil && error!.localizedDescription.count > 0 && statusCode != 401
            {
                errorMessage = error!.localizedDescription
            }
            else
            {
                switch statusCode
                {
                case 401:
                    errorMessage = "Your session has expired"
                case 402:
                    errorMessage = "UnAuthenticated"
                case 403:
                    errorMessage = "Invalid request"
                case 404:
                    errorMessage = "URL not found"
                case 500:
                    errorMessage = "Internal server error"
                default:
                    errorMessage = "Some unexpected error happened"
                }
            }
        }
    }
    
    // MARK: - Helpers
    func isConnectedToInternet() -> Bool {
        return Connectivity.isConnectedToInternet
    }
}
