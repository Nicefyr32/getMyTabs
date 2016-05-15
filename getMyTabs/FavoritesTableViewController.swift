//
//  FavoritesTableViewController.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 24/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    @IBOutlet var tableView_favoritTabs: UITableView!
    
    var coreDataService = CoreDataService()
    
    var favoritTabs :[FavoritTab] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritTabs = coreDataService.loadSongsCoreData()
        
        
        if favoritTabs.count != 0 {
            (tabBarController!.tabBar.items![1] ).badgeValue = "\(favoritTabs.count)"
        }
        
        
        // observer that get called from webViewController when tab is favored. calls func refresh list
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FavoritesTableViewController.refreshList(_:)), name:"refreshMyTableView", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoritTabs.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellFavoritTab", forIndexPath: indexPath) as! FavoriteTableViewCell
        
        // Configure the cell...
        
        cell.lbl_tabTitle.text = favoritTabs[indexPath.row].title
        cell.lbl_tabType.text = favoritTabs[indexPath.row].type
        cell.lbl_tabArtist.text = favoritTabs[indexPath.row].artist
        
        return cell
    }
    
    func refreshList(notification: NSNotification){
        favoritTabs = coreDataService.loadSongsCoreData()
        tableView_favoritTabs.reloadData()
        
        if favoritTabs.count != 0 {
            (tabBarController!.tabBar.items![1] ).badgeValue = "\(favoritTabs.count)"
        }
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            coreDataService.deleteSongCoreData(favoritTabs[indexPath.row])
            
            favoritTabs.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            (tabBarController!.tabBar.items![1] ).badgeValue = "\(favoritTabs.count)"
            
        }
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segueToFavoritSongView") {
            let segueToFavoritSongView = segue.destinationViewController as? FavoriteSongViewController
            
            
            segueToFavoritSongView?.favoritTab = (favoritTabs[(tableView.indexPathForSelectedRow?.row)!])
        }
    }

    
}
