//
//  CharacterComicModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import Foundation

class CharacterComicResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterComicResponseData
    let etag: String?

}

class CharacterComicResponseData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterComicResultModel]

}

class CharacterComicResultModel: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail: CharacterThumbnailModel

}
