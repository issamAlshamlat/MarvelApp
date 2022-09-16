//
//  CharacterComicsListViewModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation

class CharacterComicsListViewModel {
    
    var realoadList = {() -> () in }
    var errorMessage = {(message: String?) -> () in}
    
    private var storageProvider = StorageProvider.shared
    
    var comics: [ComicViewModel] = [] {
        didSet {
            realoadList()
        }
    }
    
    init(comics: [ComicViewModel]) {
        self.comics = comics
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return comics.count
    }
    
    func modelAt(indexPath: Int) -> ComicViewModel {
        return comics[indexPath]
    }
    
    func fetchData(id: Int) {

        ApiManager.shared.fetchCharacterComics(characterID: id) { [weak self] comicListViewModel, errorMessage  in
            if let comicListViewModel = comicListViewModel {
                self?.comics = comicListViewModel
                self?.storageProvider.updateCharacterComics(characterID: id, comics: comicListViewModel)
                self?.comics.forEach {
                    if let id = $0.comic.id {
                        let characterInDB = StorageProvider.shared.getComicByID(id: id)
                        characterInDB?.image = $0.imageData
                        try! StorageProvider.shared.saveData()
                    }
                }
            }else {
                self?.errorMessage(errorMessage)
            }
        }
    }
    
}

class ComicViewModel {
    
    var comic: CharacterComicResultModel
    
    init(comic: CharacterComicResultModel) {
        self.comic = comic
        
    }
    
    var imageURLString: String {
        var url = ""
        
//        if let thumbnail = comic.thumbnail {
            url = url.generateImageURLString(path: comic.thumbnail.path, extension: comic.thumbnail.extension)
//        }
        
        return url
    }
    
    var imageData: Data {
        var imageData = Data()
        
        if let imageURL = URL(string: imageURLString) {
            if let data = try? Data(contentsOf: imageURL) {
                imageData = data
            }
        }
        
        return imageData

    }
}
