//
//  LocalSource.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 29.01.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//
//

import Foundation
import CoreData

class LocalSource: LocalArticle {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<LocalSource> {
        return NSFetchRequest<LocalSource>(entityName: "LocalSource")
    }

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var article: LocalArticle?
    
    static func addSource(_ source: ArticleSource?) -> LocalSource {
        let localSource = LocalSource(context: CoreDataManager.shared.managedObjectContext)
        localSource.id = source?.id
        localSource.name = source?.name
        return localSource
    }
}
