//
//  LocalArticle.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 29.01.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//
//

import Foundation
import CoreData


class LocalArticle: NSManagedObject {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<LocalArticle> {
        return NSFetchRequest<LocalArticle>(entityName: "LocalArticle")
    }

    @NSManaged var title: String?
    @NSManaged var subTitle: String?
    @NSManaged var author: String?
    @NSManaged var url: URL?
    @NSManaged var urlToImage: String?
    @NSManaged var savingDate: Date?
    @NSManaged var source: LocalSource?
    
    static func saveArticle(_ article: Article) {
        let localArticle = LocalArticle(context: CoreDataManager.shared.managedObjectContext)
        
        localArticle.title = article.title
        localArticle.subTitle = article.description
        localArticle.urlToImage = article.urlToImage
        localArticle.url = article.url
        localArticle.savingDate = Date()
        localArticle.source = LocalSource.addSource(article.source)
    }
}
