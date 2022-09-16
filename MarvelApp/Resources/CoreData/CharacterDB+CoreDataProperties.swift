//
//  CharacterDB+CoreDataProperties.swift
//  
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//
//

import Foundation
import CoreData


extension CharacterDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterDB> {
        return NSFetchRequest<CharacterDB>(entityName: "CharacterDB")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var is_favourite: Bool
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var comics: Set<ComicDB>?
    @NSManaged public var events: Set<EventDB>?
    @NSManaged public var series: Set<SerieDB>?
    @NSManaged public var stories: Set<StoryDB>?

}

// MARK: Generated accessors for comics
extension CharacterDB {

    @objc(addComicsObject:)
    @NSManaged public func addToComics(_ value: ComicDB)

    @objc(removeComicsObject:)
    @NSManaged public func removeFromComics(_ value: ComicDB)

    @objc(addComics:)
    @NSManaged public func addToComics(_ values: NSSet)

    @objc(removeComics:)
    @NSManaged public func removeFromComics(_ values: NSSet)

}

// MARK: Generated accessors for events
extension CharacterDB {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: EventDB)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: EventDB)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

// MARK: Generated accessors for series
extension CharacterDB {

    @objc(addSeriesObject:)
    @NSManaged public func addToSeries(_ value: SerieDB)

    @objc(removeSeriesObject:)
    @NSManaged public func removeFromSeries(_ value: SerieDB)

    @objc(addSeries:)
    @NSManaged public func addToSeries(_ values: NSSet)

    @objc(removeSeries:)
    @NSManaged public func removeFromSeries(_ values: NSSet)

}

// MARK: Generated accessors for stories
extension CharacterDB {

    @objc(addStoriesObject:)
    @NSManaged public func addToStories(_ value: StoryDB)

    @objc(removeStoriesObject:)
    @NSManaged public func removeFromStories(_ value: StoryDB)

    @objc(addStories:)
    @NSManaged public func addToStories(_ values: NSSet)

    @objc(removeStories:)
    @NSManaged public func removeFromStories(_ values: NSSet)

}
