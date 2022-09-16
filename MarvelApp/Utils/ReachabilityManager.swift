//
//  ReachabilityManager.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import Foundation
import Reachability

public protocol NetworkListener: AnyObject {
    func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }

    var reachabilityStatus: Reachability.Connection = .unavailable
    var listeners = [NetworkListener]()
    let reachability = try! Reachability()
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .unavailable:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        default:
            break
        }
        
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }
        
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring(){
       reachability.stopNotifier()
       NotificationCenter.default.removeObserver(self,
                                                 name: Notification.Name.reachabilityChanged,
                   object: reachability)
    }
    
    //MARK: - Add/Remove Listener
    
    func addListener(listener: NetworkListener){
        listeners.append(listener)
    }
    
    func removeListener(listener: NetworkListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
