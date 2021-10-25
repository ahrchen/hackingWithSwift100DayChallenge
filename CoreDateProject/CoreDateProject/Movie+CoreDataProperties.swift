//
//  Movie+CoreDataProperties.swift
//  CoreDateProject
//
//  Created by Raymond Chen on 10/21/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    public var wwrappedTitle: String {
        title ?? "Unknown Title"
    }
}

extension Movie : Identifiable {

}
