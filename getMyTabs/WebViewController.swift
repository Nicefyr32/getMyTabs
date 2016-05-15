//
//  WebViewController.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 23/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var htmlParser = HtmlParser()
    var coreDataService = CoreDataService()
    
    var songObject = Tab()
    
    
    @IBAction func btn_favoriteSong(sender: UIBarButtonItem) {
        
        coreDataService.saveTabCoreData(songObject)
        
        updateFavoriteTableView()
    
        animateView()
        

    }

    @IBOutlet weak var blurView_addedTab: UIView!
    
    @IBOutlet weak var visualEffectView_addedTab: UIVisualEffectView!
    
    @IBOutlet weak var navigationItem_songTitle: UINavigationItem!
    
    @IBOutlet weak var txtView_html: UITextView!
    
    @IBOutlet weak var stepper_outletFontsize: UIStepper!
    
    @IBAction func stepper_fontSize(sender: AnyObject) {
        txtView_html.font = UIFont(name: "Courier New", size: CGFloat(stepper_outletFontsize.value))
    }
    
    override func viewDidLoad() {
        songObject.tab = htmlParser.getTabContent(songObject.url)
        visualEffectView_addedTab.layer.masksToBounds = true;
        visualEffectView_addedTab.layer.cornerRadius = 10;
        visualEffectView_addedTab.hidden = true
        
        self.txtView_html.text = songObject.tab
        self.txtView_html.font = UIFont(name: "Courier New", size: 14)
        
        navigationItem_songTitle.title = songObject.title
        stepper_outletFontsize.value = 14
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateFavoriteTableView(){
        
        let tabCount = coreDataService.getNumberOfTabs()
        
        if tabCount != 0 {
            (tabBarController!.tabBar.items![1] ).badgeValue = "\(tabCount)"
        }
        NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)

    }

    func animateView(){
        visualEffectView_addedTab.hidden = false
        
        UIView.animateWithDuration(0.3, animations: {
            self.visualEffectView_addedTab.alpha = 1.0
            
            }, completion: {
                (Completed: Bool)  -> Void in
                
                UIView.animateWithDuration(0.3,
                    delay: 1.0,
                    options: UIViewAnimationOptions.CurveLinear,
                    animations: {
                    
                        self.visualEffectView_addedTab.alpha = 0
                    },
                    completion: { (Completed : Bool) -> Void in
//                        self.animateView()  // run the animation again
                        self.visualEffectView_addedTab.hidden = true
                })
        })
        
        
        
    }

}
