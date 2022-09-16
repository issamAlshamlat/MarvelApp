//
//  CharacterSerieModel.swift
//  TottersTest
//
//  Created by Mhd Baher on 15/09/2022.
//

import Foundation

class CharacterSerieResponse: Decodable {
    
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: CharacterSerieResponseData?

}

class CharacterSerieResponseData: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterSerieResultModel]
    
}

class CharacterSerieResultModel: Decodable {
    
    let id: Int
    let title: String?
    let description: String?
    let thumbnail: CharacterThumbnailModel?
    let startYear: Int?
    let endYear: Int?

}
