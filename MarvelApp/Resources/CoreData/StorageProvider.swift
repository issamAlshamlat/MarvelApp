//
//  StorageProvider.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 14/09/2022.
//

import Foundation
import CoreData

class StorageProvider {

    static let shared: StorageProvider = .init()

    private let persistentContainer: NSPersistentContainer

    var counter = 0
    
    private init() {
        persistentContainer = .init(name: "MarvelApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core data store failed to load with error: \(error)")
            }
        }
    }
    
    func getAllCharacters() throws -> [CharacterDB] {
        let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            rollBack()
            print("error fetching data.")
            throw error
        }
    }

    func updateCharactersFromDataBase(characters: [CharacterViewModel]) {
        
        characters.forEach {
            let newEntity = CharacterDB(context: persistentContainer.viewContext)
            let character = $0.character
            
            if getCharacterByID(id: character.id) == nil {
                newEntity.id = Int64(character.id)
                newEntity.name = character.name
                newEntity.desc = character.description
                newEntity.is_favourite = false
            
                do {
                    try saveData()
                } catch {
                    print(error)
                    rollBack()
                }
            }
        }
    }
    
    func updateCharacterStories(characterID: Int, stories: [StoryViewModel]) {
        stories.forEach {
            let newEntity = StoryDB(context: persistentContainer.viewContext)
            let storyVM = $0.story
            
            if getCharacterByID(id: characterID) != nil {
                if getStoryByID(id: storyVM.id) == nil {
                    newEntity.id = Int64(storyVM.id)
                    newEntity.title = storyVM.title
                    newEntity.desc = storyVM.description
                    newEntity.number_of_comics = "\(storyVM.comics.available)"
                    newEntity.number_of_events = "\(storyVM.events.available)"
                    newEntity.number_of_characters = "\(storyVM.characters.available)"
                    newEntity.number_of_series = "\(storyVM.series.available)"
                    newEntity.type = storyVM.type
                    newEntity.character = getCharacterByID(id: characterID)
                    
                    do {
                        try saveData()
                    } catch {
                        print(error)
                        rollBack()
                    }
                }
            }
        }

    }
    
    func updateCharacterComics(characterID: Int, comics: [ComicViewModel]) {
        comics.forEach {
            let newEntity = ComicDB(context: persistentContainer.viewContext)
            let comicVM = $0.comic
            
            if getCharacterByID(id: characterID) != nil {
                if let id = comicVM.id {
                    if getComicByID(id: id) == nil {
                        newEntity.id = Int64(id)
                        newEntity.title = comicVM.title
                        newEntity.desc = comicVM.description
                        newEntity.character = getCharacterByID(id: characterID)
                        
                        do {
                            try saveData()
                        } catch {
                            print(error)
                            rollBack()
                        }
                    }
                }
            }
        }

    }
    
    func updateCharacterSeries(characterID: Int, series: [SerieViewModel]) {
        series.forEach {
            let newEntity = SerieDB(context: persistentContainer.viewContext)
            let serieVM = $0.serie
            
            if getCharacterByID(id: characterID) != nil {
                if getSerieByID(id: serieVM.id) == nil {
                    newEntity.id = Int64(serieVM.id)
                    newEntity.title = serieVM.title
                    newEntity.desc = serieVM.description
                    
                    if let startYear = serieVM.startYear {
                        newEntity.start_year = Int16(startYear)
                    }
                    
                    if let endYear = serieVM.endYear {
                        newEntity.end_year = Int16(endYear)
                    }
                    
                    newEntity.character = getCharacterByID(id: characterID)
                    
                    do {
                        try saveData()
                    } catch {
                        print(error)
                        rollBack()
                    }
                }
            }
        }

    }
    
    func updateCharacterEvents(characterID: Int, events: [EventViewModel]) {
        events.forEach {
            let newEntity = EventDB(context: persistentContainer.viewContext)
            let eventVM = $0.event
            
            if getCharacterByID(id: characterID) != nil {
                if getEventByID(id: eventVM.id) == nil {
                    newEntity.id = Int64(eventVM.id)
                    newEntity.title = eventVM.title
                    newEntity.desc = eventVM.description
                    newEntity.start = eventVM.start
                    newEntity.end = eventVM.end
                    newEntity.character = getCharacterByID(id: characterID)
                    
                    do {
                        try saveData()
                    } catch {
                        print(error)
                        rollBack()
                    }
                }
            }
        }

    }
    
    func getAllItems() throws -> [CharacterDB] {
        let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            rollBack()
            print("error fetching data.")
            throw error
        }
    }

    func isCharacterFavorite(id: Int) -> Bool {
        guard let entity = getCharacterByID(id: id)
        else { return false }
        return entity.is_favourite
    }

    func getCharacterByID(id: Int) -> CharacterDB? {
        let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()

        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id as NSNumber)
        fetchRequest.predicate = idPredicate
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
    func getComicByID(id: Int) -> ComicDB? {
        let fetchRequest: NSFetchRequest<ComicDB> = ComicDB.fetchRequest()

        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id as NSNumber)
        fetchRequest.predicate = idPredicate
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
    func getStoryByID(id: Int) -> StoryDB? {
        let fetchRequest: NSFetchRequest<StoryDB> = StoryDB.fetchRequest()

        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id as NSNumber)
        fetchRequest.predicate = idPredicate
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
    func getSerieByID(id: Int) -> SerieDB? {
        let fetchRequest: NSFetchRequest<SerieDB> = SerieDB.fetchRequest()

        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id as NSNumber)
        fetchRequest.predicate = idPredicate
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
    func getEventByID(id: Int) -> EventDB? {
        let fetchRequest: NSFetchRequest<EventDB> = EventDB.fetchRequest()

        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id as NSNumber)
        fetchRequest.predicate = idPredicate
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }

    func updateFavorite(characterID: Int, favorite: Bool) {

        if let existingEntity = getCharacterByID(id: characterID) {
            existingEntity.is_favourite = favorite
        }
        
        do {
            try saveData()
        } catch {
            print(error)
            rollBack()
        }
    }
}

extension StorageProvider {
    private func rollBack() {
        DispatchQueue.main.async {
            self.persistentContainer.viewContext.rollback()
        }
    }

    func saveData() throws {
        try self.persistentContainer.viewContext.save()
    }

    func removeFromCoreData(id: Int) {

        let managedcontext = AppDelegate.sharedAppDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "OrderFaves")
        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id)
        fetchRequest.predicate = idPredicate
        let deleterequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedcontext.execute(deleterequest)
        } catch {
            print(error)
        }
    }
    
    func removeAllItems() {
        let managedcontext = AppDelegate.sharedAppDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Car")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedcontext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
}
