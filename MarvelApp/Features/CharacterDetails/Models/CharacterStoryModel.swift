//
//  CharacterStoryModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation

class CharacterStoryResponse: Decodable {
    
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: CharacterStoryResponseData?
    let etag: String

}

class CharacterStoryResponseData: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterStoryResultModel]

}

class CharacterStoryResultModel: Decodable {
    
    let id: Int
    let title: String?
    let description: String?
    let thumbnail: CharacterThumbnailModel?
    let comics: StoryItemModel
    let series: StoryItemModel
    let events: StoryItemModel
    let characters: StoryItemModel
    let creators: StoryItemModel
    let type: String
}

class StoryItemModel: Decodable {
    let available: Int
}
