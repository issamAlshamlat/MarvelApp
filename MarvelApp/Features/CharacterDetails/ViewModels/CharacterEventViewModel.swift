//
//  CharacterEventViewModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation

class CharacterEventListViewModel {
    
    var realoadList = {() -> () in }
    var errorMessage = {(message: String?) -> () in}
    
    private var storageProvider = StorageProvider.shared
    
    var events: [EventViewModel] = [] {
        didSet {
            realoadList()
        }
    }
    
    init(events: [EventViewModel]) {
        self.events = events
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return events.count
    }
    
    func modelAt(indexPath: Int) -> EventViewModel {
        return events[indexPath]
    }
    
    func fetchData(id: Int) {
        
        ApiManager.shared.fetchCharacterEvents(characterID: id) { [weak self] eventListViewModel, errorMessage  in
            if let eventListViewModel = eventListViewModel {
                self?.events = eventListViewModel
                self?.storageProvider.updateCharacterEvents(characterID: id, events: eventListViewModel)
                
                self?.events.forEach {
                    let characterInDB = StorageProvider.shared.getEventByID(id: $0.event.id)
                    
                    if let imageURL = URL(string: $0.imageURLString) {
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: imageURL) {
                                characterInDB?.image = data
                            }
                        }
                    }
                    
                    try! StorageProvider.shared.saveData()
                }
                
            }else {
                self?.errorMessage(errorMessage)
            }
        }
    }
    
}

class EventViewModel {
    
    var event: CharacterEventResultModel
    
    init(event: CharacterEventResultModel) {
        self.event = event
    }
    
    var imageURLString: String {
        var url = ""
        
        if let thumbnail = event.thumbnail {
            url = url.generateImageURLString(path: thumbnail.path, extension: thumbnail.extension)
        }
        
        return url

    }

}
