//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 14/09/2022.
//

import Foundation

class CharacterListViewModel {
    
    var realoadList = {() -> () in }
    var errorMessage = {(message: String?) -> () in}
    var nextPageAvailable = false
    var isPageRefreshing: Bool = false
    var offset = 0
    
    private var storageProvider = StorageProvider.shared
    
    var characters: [CharacterViewModel] = [] {
        didSet {
            realoadList()
        }
    }
    
    init(characters: [CharacterViewModel]) {
        self.characters = characters
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return characters.count
    }
    
    func modelAt(indexPath: Int) -> CharacterViewModel {
        return characters[indexPath]
    }
    
    func fetchData() {
      
        ApiManager.shared.fetchCharacters(offset: "\(offset)") {[weak self] characterListViewModel, error, hasNextPage, offset   in
            
            self?.offset = offset
            self?.nextPageAvailable = hasNextPage
            
            if let characterListViewModel = characterListViewModel {
                self?.isPageRefreshing = false
                self?.characters += characterListViewModel
                self?.storageProvider.updateCharactersFromDataBase(characters: characterListViewModel)
                
                self?.characters.forEach {
                    let characterInDB = StorageProvider.shared.getCharacterByID(id: $0.character.id)
                    characterInDB?.image = $0.imageData
                    try! StorageProvider.shared.saveData()
                }
            }else {
                self?.errorMessage(error)
            }
        }
    }
}

class CharacterViewModel {
    let character: CharacterModel
    
    init(character: CharacterModel) {
        self.character = character
    }
    
    var imageURLString: String {
        let url = ""
        return url.generateImageURLString(path: character.thumbnail.path, extension: character.thumbnail.extension)
    }
    
    var imageData: Data {
        var imageData = Data()
        
        if let imageURL = URL(string: imageURLString) {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: imageURL) {
                    imageData = data
                }
            }
        }
        
        return imageData

    }
    
    var isFavourite: Bool {
        return StorageProvider.shared.isCharacterFavorite(id: Int(character.id))
    }

}
