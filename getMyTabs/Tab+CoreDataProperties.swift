//
//  Tab+CoreDataProperties.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 27/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import Foundation
import CoreData

extension Tab {
    
    @NSManaged var url: String?
    @NSManaged var title: String?
    @NSManaged var artist: String?
    @NSManaged var type: String?
    @NSManaged var tabText: String?
    
}

