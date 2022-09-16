//
//  SerieDB+CoreDataProperties.swift
//  
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//
//

import Foundation
import CoreData


extension SerieDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SerieDB> {
        return NSFetchRequest<SerieDB>(entityName: "SerieDB")
    }

    @NSManaged public var id: Int64
    @NSManaged public var desc: String?
    @NSManaged public var end_year: Int16
    @NSManaged public var start_year: Int16
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var character: CharacterDB?

}
