//
//  CharacterEventModel.swift
//  TottersTest
//
//  Created by Mhd Baher on 15/09/2022.
//

import Foundation

class CharacterEventResponse: Decodable {
    
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: CharacterEventResponseData?
    let etag: String
    
}

class CharacterEventResponseData: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterEventResultModel]

}

class CharacterEventResultModel: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let thumbnail: CharacterThumbnailModel?
    let start: String
    let end: String
    
}
