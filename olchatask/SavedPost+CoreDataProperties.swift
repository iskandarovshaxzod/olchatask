//
//  SavedPost+CoreDataProperties.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//
//

import Foundation
import CoreData


extension SavedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPost> {
        return NSFetchRequest<SavedPost>(entityName: "SavedPost")
    }

    @NSManaged public var authorID: Int64
    @NSManaged public var authorName: String?
    @NSManaged public var body: String?
    @NSManaged public var postID: Int64
    @NSManaged public var title: String?

}

extension SavedPost : Identifiable {

}
