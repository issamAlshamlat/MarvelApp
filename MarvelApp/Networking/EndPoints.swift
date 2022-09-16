//
//  EndPoints.swift
//  MarvelApp
//
//  Created by Mhd Baher on 15/09/2022.
//

import Foundation

// MARK: - API Endpoints
enum Endpoint: String {
    
    case characters = "/characters"
    case characterByID = "/characters/%@"
    case comics = "/characters/%@/comics"
    case events = "/characters/%@/events"
    case series = "/characters/%@/series"
    case stories = "/characters/%@/stories"
    
}
