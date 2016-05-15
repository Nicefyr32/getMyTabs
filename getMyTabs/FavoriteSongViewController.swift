//
//  favoriteSongViewController.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 24/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit

class FavoriteSongViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    
    var favoritTab : FavoritTab?
    var indexInCoreData = 0
    
    @IBOutlet weak var textView_tab: UITextView!
    
    @IBOutlet weak var navigationItem_songTitle: UINavigationItem!
    
    @IBAction func stepper_actionFontSize(sender: UIStepper) {
        
        textView_tab.font = UIFont(name: "Courier New", size: CGFloat(stepper_outletFontsize.value))
    }
    
    @IBOutlet weak var stepper_outletFontsize: UIStepper!
    
    @IBOutlet weak var barButton_editTabOutlet: UIBarButtonItem!
    
    @IBAction func barButton_editTab(sender: UIBarButtonItem) {
        
        if (barButton_editTabOutlet.title == "Edit") {
            textView_tab.editable = true
            textView_tab.selectable = true
            barButton_editTabOutlet.title = "Save"
            
        } else {
            textView_tab.editable = false
            textView_tab.selectable = false
            barButton_editTabOutlet.title = "Edit"
            
            favoritTab?.tab = textView_tab.text
            
            coreDataService.updateFavoriteSong(favoritTab!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView_tab.text = favoritTab!.tab
        stepper_outletFontsize.value = 14
        textView_tab.font = UIFont(name: "Courier New", size: CGFloat(stepper_outletFontsize.value))
        navigationItem_songTitle.title = favoritTab?.title


        // Do any additional setup after loading the view.
    }
    
    // removes keyboard when the sceen is tabbed
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textView_tab.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
