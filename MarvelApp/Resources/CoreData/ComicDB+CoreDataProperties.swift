//
//  ComicDB+CoreDataProperties.swift
//  
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//
//

import Foundation
import CoreData


extension ComicDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicDB> {
        return NSFetchRequest<ComicDB>(entityName: "ComicDB")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var character: CharacterDB?

}
