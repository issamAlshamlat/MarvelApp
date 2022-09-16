//
//  CharacterStoryListViewModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation

class CharacterStoryListViewModel {
    
    var realoadList = {() -> () in }
    var errorMessage = {(message: String?) -> () in}
    
    private var storageProvider = StorageProvider.shared
    
    var stories: [StoryViewModel] = [] {
        didSet {
            realoadList()
        }
    }
    
    init(stories: [StoryViewModel]) {
        self.stories = stories
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return stories.count
    }
    
    func modelAt(indexPath: Int) -> StoryViewModel {
        return stories[indexPath]
    }
    
    func fetchData(id: Int) {
      
        ApiManager.shared.fetchCharacterStories(characterID: id) { [weak self] storyListViewModel, errorMessage  in
            if let storyListViewModel = storyListViewModel {
                self?.stories = storyListViewModel
                self?.storageProvider.updateCharacterStories(characterID: id, stories: storyListViewModel)
            }else {
                self?.errorMessage(errorMessage)
            }
        }
    }
    
}

class StoryViewModel {
    
    var story: CharacterStoryResultModel
    
    init(story: CharacterStoryResultModel) {
        self.story = story
        
    }
    
    var imageURLString: String {
        var url = ""

        if let thumbnail = story.thumbnail {
            url = url.generateImageURLString(path: thumbnail.path, extension: thumbnail.extension)
        }
        
        return url
    }
    
}
