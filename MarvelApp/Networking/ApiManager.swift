//
//  ApiManager.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: BaseRequestManager {
    
    static let shared = ApiManager()
    
    private override init() {}
    
    private func hasNextPage(model: CharacterResponseData) -> Bool {
        let offset = model.offset
        let total = model.total
        let limit = model.limit
        
        if total > (limit * offset) {
            return true
        }
        
        return false
    }
    
    func fetchCharacters(offset: String, completionHandler: @escaping ([CharacterViewModel]?, String?, Bool, Int) -> Void) {
        Alamofire.request(BaseRequestManager.endpoint(.characters, offset: offset) , method: .get).responseJSON { response in
            var characterList = [CharacterViewModel]()
            var hasNextPage = false
            var offset = 0
            
            switch response.result {
            case .success(_):
                do {
                    let charactersResponse = try JSONDecoder().decode(CharacterResponse.self, from: response.data!)
                    let characters = charactersResponse.data.results
                    characters.forEach {
                        let characterVM = CharacterViewModel(character: $0)
                        characterList.append(characterVM)
                    }
                    
                    let paginationData = charactersResponse.data
                    
                    hasNextPage = self.hasNextPage(model: paginationData)
                    offset = paginationData.limit + paginationData.offset
                    
                    completionHandler(characterList, nil, hasNextPage, offset)
                    
                } catch let error as NSError {
                    completionHandler(nil,error.localizedDescription, hasNextPage, offset)
                }
            case .failure(let error):
                completionHandler(nil,error.localizedDescription, hasNextPage, offset)
            }
        }
    }
    
    func fetchCharacterByID(characterID: Int, completionHandler: @escaping (CharacterViewModel?, String?) -> Void) {
        Alamofire.request(BaseRequestManager.endpoint(.characterByID, resource: characterID) , method: .get).responseJSON { response in
            
            switch response.result {
            case .success(_):
                do {
                    if let data = response.data {
                        let charactersResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                        let characters = charactersResponse.data.results
                        let characterVM = CharacterViewModel(character: characters[0])
                            completionHandler(characterVM, nil)
                            
                        }
                    } catch let error as NSError {
                        print(error)
                        completionHandler(nil,error.localizedDescription)
                    }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil,error.localizedDescription)
            }
            
        }
    }
    
    func fetchCharacterComics(characterID: Int, completionHandler: @escaping ([ComicViewModel]?, String?) -> Void) {
        Alamofire.request(BaseRequestManager.endpoint(.comics, resource: characterID) , method: .get).responseJSON { response in
            var comicList = [ComicViewModel]()
            
            switch response.result {
            case .success(_):
                do {
                    if let data = response.data {
                        let comicsResponse = try JSONDecoder().decode(CharacterComicResponse.self, from: data)
                        
                        let comics = comicsResponse.data.results
                            comics.forEach {
                                let comicVM = ComicViewModel(comic: $0)
                                comicList.append(comicVM)
                            }
                            
                            completionHandler(comicList, nil)
                            
                        }
                    } catch let error as NSError {
                        print(error)
                        completionHandler(nil,error.localizedDescription)
                    }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil,error.localizedDescription)
            }
            
        }
    }
    
    func fetchCharacterStories(characterID: Int, completionHandler: @escaping ([StoryViewModel]?, String?) -> Void) {

        Alamofire.request(BaseRequestManager.endpoint(.stories, resource: characterID) , method: .get).responseJSON { response in
            var storyList = [StoryViewModel]()
            
            switch response.result {
            case .success(_):
                do {
                    let storiesResponse = try JSONDecoder().decode(CharacterStoryResponse.self, from: response.data!)
                    if let responseData = storiesResponse.data {
                        let stories = responseData.results
                        stories.forEach {
                            let storyVM = StoryViewModel(story: $0)
                            storyList.append(storyVM)
                        }
                        
                        print(stories.count)
                        completionHandler(storyList, nil)
                    }
                    
                } catch let error as NSError {
                    print(error)
                    completionHandler(nil,error.localizedDescription)
                }
            case .failure(let error):
                completionHandler(nil,error.localizedDescription)
            }
            
        }
    }
    
    func fetchCharacterSeries(characterID: Int, completionHandler: @escaping ([SerieViewModel]?, String?) -> Void) {
        
        Alamofire.request(BaseRequestManager.endpoint(.series, resource: characterID) , method: .get).responseJSON { response in
            var seriesList = [SerieViewModel]()
            
            switch response.result {
            case .success(_):
                do {
                    let steriesResponse = try JSONDecoder().decode(CharacterSerieResponse.self, from: response.data!)
                    if let responseData = steriesResponse.data {
                        let series = responseData.results
                        series.forEach {
                            let serieVM = SerieViewModel(serie: $0)
                            seriesList.append(serieVM)
                        }
        
                        completionHandler(seriesList, nil)
                    }
                    
                } catch let error as NSError {
                    print(error)
                    completionHandler(nil,error.localizedDescription)
                }
            case .failure(let error):
                completionHandler(nil,error.localizedDescription)
            }
            
        }
    }
    
    func fetchCharacterEvents(characterID: Int, completionHandler: @escaping ([EventViewModel]?, String?) -> Void) {
        
        Alamofire.request(BaseRequestManager.endpoint(.events, resource: characterID) , method: .get).responseJSON { response in
            var eventsList = [EventViewModel]()
            
            switch response.result {
            case .success(_):
                do {
                    let eventssResponse = try JSONDecoder().decode(CharacterEventResponse.self, from: response.data!)
                    if let responseData = eventssResponse.data {
                        let events = responseData.results
                        events.forEach {
                            let eventVM = EventViewModel(event: $0)
                            eventsList.append(eventVM)
                        }
        
                        completionHandler(eventsList, nil)
                    }
                    
                } catch let error as NSError {
                    print(error)
                    completionHandler(nil,error.localizedDescription)
                }
            case .failure(let error):
                completionHandler(nil,error.localizedDescription)
            }
            
        }
    }
}
