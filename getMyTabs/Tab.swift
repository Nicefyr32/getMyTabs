//
//  Tab.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 27/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import Foundation
import CoreData

class Tab {
    
    var url: String = ""
    var title: String = ""
    var artist: String = ""
    var type: String = ""
    var tab: String = ""
    
    init(url: String, title: String, artist: String, type: String, tab: String) {
        self.url = url
        self.title = title
        self.artist = artist
        self.type = type
        self.tab = tab
    }
    
    init() {
    }
    
}