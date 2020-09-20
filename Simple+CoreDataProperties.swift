//
//  Simple+CoreDataProperties.swift
//  simpledata
//
//  Created by user on 9/20/20.
//
//

import Foundation
import CoreData


extension Simple {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Simple> {
        return NSFetchRequest<Simple>(entityName: "Simple")
    }

    @NSManaged public var name: String?

}

extension Simple : Identifiable {

}
