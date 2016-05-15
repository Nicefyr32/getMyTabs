//
//  coreDataService.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 27/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var favoriteTabs : [FavoritTab] = []
    
    func saveTabCoreData(tab: Tab) {
        
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("FavoritTab", inManagedObjectContext:managedContext)
        
        let favoritTab = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        favoritTab.setValue(tab.type, forKey: "type")
        favoritTab.setValue(tab.artist, forKey: "artist")
        favoritTab.setValue(tab.title, forKey: "title")
        favoritTab.setValue(tab.tab, forKey: "tab")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func loadSongsCoreData() -> [FavoritTab] {
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "FavoritTab")

        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            favoriteTabs = results as! [FavoritTab]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return favoriteTabs
    }
    
    func updateFavoriteSong(favoriteTab : FavoritTab) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let predicate = NSPredicate(format: "tab == %@", favoriteTab.tab!)
        
        let fetchRequest = NSFetchRequest(entityName: "FavoritTab")
        fetchRequest.predicate = predicate
        
        
        do {
            let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest) as! [FavoritTab]
            fetchedEntities.first?.tab = favoriteTab.tab
            // ... Update additional properties with new values
        } catch {
            // Do something in response to error condition
        }
        
        do {
            try managedContext.save()
        } catch {
            // Do something in response to error condition
        }
        
    }
    
    func deleteSongCoreData(tab: FavoritTab) {
        
        let managedContext = appDelegate.managedObjectContext
        
        managedContext.deleteObject(tab)
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("bug in saving \(error)")
        }
        
    }
    
    func getNumberOfTabs() -> Int {
        
        let managedContext = appDelegate.managedObjectContext
        
        let countRequest = NSFetchRequest(entityName: "FavoritTab")
        
        return managedContext.countForFetchRequest(countRequest, error: nil)
        
    }
 
}