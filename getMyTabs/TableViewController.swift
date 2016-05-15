//
//  TableViewController.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 23/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var btn_outletGetMoreTabs: UIButton!
    
    @IBOutlet weak var lbl_searchedSong: UILabel!
    
    @IBAction func btn_getMoreTabs(sender: AnyObject) {
        pageCount += 1
        
        if pageCount != 1 {
            let moreTabs :[Tab] = htmlParser.getMoreTabs(tabSearchName, page: pageCount)
            
            sleep(1)
            
            tabs = moreTabs
            
            if (tabs.count == 0) {
                btn_outletGetMoreTabs.tintColor = UIColor(white: 0, alpha: 1.0)
                btn_outletGetMoreTabs.enabled = true
                btn_outletGetMoreTabs.setTitle("No more tabs avaliable", forState: UIControlState.Normal)
            }
            
            tableView.reloadData()
        }
        
    }
    
    var pageCount :Int = 1
    
    var htmlParser = HtmlParser()
    
    var tabSearchName = ""
    
    var tabs :[Tab] = []
    
    override func viewDidLoad() {
        
        
        // find out a better way to retrieve the data
        htmlParser.getTabs(tabSearchName)
        
        sleep(1) // wait to to finish the getTabs method
        
        tabs = htmlParser.tabs
        
        super.viewDidLoad()
        
        lbl_searchedSong.text = "You searched for \(tabSearchName)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tabs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSongSearch", forIndexPath: indexPath) as! SongForTableViewCell

        // Configure the cell...
        cell.lbl_tabTitle.text = "\(tabs[indexPath.row].title)"
        cell.lbl_tabType.text = "\(tabs[indexPath.row].type)"
        cell.lbl_tabArtist.text = "\(tabs[indexPath.row].artist)"
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segueToWebView") {
            let segueToWebView = segue.destinationViewController as? WebViewController
            
            segueToWebView?.songObject = tabs[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }


}
