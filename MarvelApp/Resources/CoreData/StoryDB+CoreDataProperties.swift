//
//  StoryDB+CoreDataProperties.swift
//  
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//
//

import Foundation
import CoreData


extension StoryDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryDB> {
        return NSFetchRequest<StoryDB>(entityName: "StoryDB")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var number_of_characters: String?
    @NSManaged public var number_of_comics: String?
    @NSManaged public var number_of_creators: String?
    @NSManaged public var number_of_events: String?
    @NSManaged public var number_of_series: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var character: CharacterDB?

}
