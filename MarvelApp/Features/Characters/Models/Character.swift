//
//  Character.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import Foundation

class CharacterResponse: Decodable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: CharacterResponseData
    let etag: String
    
}

class CharacterResponseData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterModel]

}

class CharacterModel: Decodable {
    var id: Int
    var name: String
    var description: String
    var modified: String
    var resourceURI: String
    var urls: [CharacterURLModel]
    var thumbnail: CharacterThumbnailModel
    var comics: CharacterCategory
    var stories: CharacterCategory
    var events: CharacterCategory
    var series: CharacterCategory
    
}

class CharacterURLModel: Decodable {
    let type: String
    let url: String
    
}

class CharacterThumbnailModel: Decodable {
    let path: String
    let `extension`: String

}

class CharacterCategory: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [CharacterCategoryItem]
    
}

class CharacterCategoryItem: Decodable {
    let resourceURI: String
    let name: String

}

