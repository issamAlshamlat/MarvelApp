//
//  EventDB+CoreDataProperties.swift
//  
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//
//

import Foundation
import CoreData


extension EventDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventDB> {
        return NSFetchRequest<EventDB>(entityName: "EventDB")
    }

    @NSManaged public var id: Int64
    @NSManaged public var desc: String?
    @NSManaged public var start: String?
    @NSManaged public var end: String?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?
    @NSManaged public var character: CharacterDB?

}
