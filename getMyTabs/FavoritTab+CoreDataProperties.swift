//
//  FavoritTab+CoreDataProperties.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 29/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FavoritTab {

    @NSManaged var artist: String?
    @NSManaged var tab: String?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var url: String?
    
    convenience init(url: String, title: String, artist: String, type: String, tabText: String) {
        self.init()
        self.url = url
        self.title = title
        self.artist = artist
        self.type = type
        self.tab = tabText
    }
    
    convenience init() {
        self.init()
    }

}
