//
//  CharacterSerieViewModel.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import Foundation

class CharacterSerieListViewModel {
    
    var realoadList = {() -> () in }
    var errorMessage = {(message: String?) -> () in}
    
    private var storageProvider = StorageProvider.shared
    
    var series: [SerieViewModel] = [] {
        didSet {
            realoadList()
        }
    }
    
    init(series: [SerieViewModel]) {
        self.series = series
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return series.count
    }
    
    func modelAt(indexPath: Int) -> SerieViewModel {
        return series[indexPath]
    }
    
    func fetchData(id: Int) {
      
        ApiManager.shared.fetchCharacterSeries(characterID: id) { [weak self] serieListViewModel, errorMessage  in
            if let serieListViewModel = serieListViewModel {
                self?.series = serieListViewModel
                self?.storageProvider.updateCharacterSeries(characterID: id, series: serieListViewModel)
                
                self?.series.forEach {
                    let characterInDB = StorageProvider.shared.getEventByID(id: $0.serie.id)
                    
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

class SerieViewModel {
    
    var serie: CharacterSerieResultModel
    
    init(serie: CharacterSerieResultModel) {
        self.serie = serie
    }
    
    var imageURLString: String {
        var url = ""
        
        if let thumbnail = serie.thumbnail {
            url = url.generateImageURLString(path: thumbnail.path, extension: thumbnail.extension)
        }
        
        return url

    }
}
