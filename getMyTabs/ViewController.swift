//
//  ViewController.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 08/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit
import Fuzi

class ViewController: UIViewController {
    
    var coredataService = CoreDataService()
    
    @IBOutlet weak var imageView_backgroundSearch: UIImageView!
    
    @IBOutlet weak var txtField_songTitle: UITextField!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBAction func btn_searchSong(sender: AnyObject) {
        
    }
        
    override func viewDidLoad() {
        
        blurView.layer.cornerRadius = 7;
        blurView.layer.masksToBounds = true;
        
        super.viewDidLoad()
        
        imageView_backgroundSearch.image = UIImage(named: "W8LcA")
        
        let tabCount = coredataService.getNumberOfTabs()
        
        if tabCount != 0 {
            (tabBarController!.tabBar.items![1] ).badgeValue = "\(tabCount)"
        }
        
        
    }
    
    // removes keyboard when the sceen is tabbed
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtField_songTitle.endEditing(true)
    }
    
    // removes keyboard when the sceen is tabbed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        performSegueWithIdentifier("segueToTableWebView", sender: nil)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueToTableWebView") {
            let segueToTableViewSongs = segue.destinationViewController as? TableViewController
            segueToTableViewSongs?.tabSearchName = txtField_songTitle.text!
        }
    }
    
    

    

}

