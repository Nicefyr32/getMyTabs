//
//  HtmlParser.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 27/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import Foundation
import Fuzi

class HtmlParser {
    var tabs :[Tab] = []
    
    
    // Method that retrives the list of tabs in the url by a specific search
    func getTabs(search :String) -> [Tab] {
        // get request
        do {
            
            let filtertSongName = search.stringByReplacingOccurrencesOfString(" ", withString: "+")
            
            let opt = try HTTP.GET("https://www.ultimate-guitar.com/search.php?search_type=title&order=&value=\(filtertSongName)")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                let html = response.text!
                
                do {
                    // if encoding is omitted, it defaults to NSUTF8StringEncoding
                    let doc = try HTMLDocument(string: html, encoding: NSUTF8StringEncoding)
                    
                    var artist = ""
                    var title = ""
                    var url = ""
                    var i = 0
                    for row in doc.css(".tresults tr") { // for each row in table result
                        if i == 0 {
                            i += 1
                            continue
                        }
                        
                        
                        // Find artist
                        let artistColumn = row.css(".search_art") //
                        
                        if artistColumn.count > 0 {
                            artist = (artistColumn[0]?.stringValue)!
                        }
                        
                        // Find type
                        let type = row.children[3].stringValue
                        
                        if(type == "power tab" || type == "guitar pro" || type == "tab pro" || type == "video lesson") {
                            continue
                        }
                        print(type)
                        
                        // Find song og URL
                        let songTitleAndUrl = row.css(".result-link")
                        
                        if songTitleAndUrl.count > 0 {
                        //    print(songTitleAndUrl[0]?.stringValue) // song title
                        //    print(songTitleAndUrl[0]?["href"]) // song URL
                            title = (songTitleAndUrl[0]?.stringValue)!
                            url = (songTitleAndUrl[0]?["href"])!
                        }
                        
                        //print(artist.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
                        print()
                        
                        let tab = Tab()
                        tab.artist = artist.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) // trim out white space before and after
                        tab.title = title
                        tab.url = url
                        tab.type = type
                        
                        i += 1
                        
                        self.tabs.append(tab)
                        
                        
                        
                        
                    }
                    
                    
                } catch let error {
                    print(error)
                }
                
                
                
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        return tabs
        
    }
    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = String(data: data!, encoding:
                    NSASCIIStringEncoding)!
                callback(result, nil)
            }
        }
        task.resume()
    }
    
    // Method that retrives the list of tabs in the url by a specific search
    func getMoreTabs(search :String, page :Int) -> [Tab] {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.ultimate-guitar.com" )!)
    
        httpGet(request){ (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                print(data)
            }
        }
        
        return self.tabs
        
        
        // get request
        do {
            
            let filtertSongName = search.stringByReplacingOccurrencesOfString(" ", withString: "+")
            
            let opt = try HTTP.GET("https://www.ultimate-guitar.com/search.php?title=\(filtertSongName)&page=\(page)&tab_type_group=text&app_name=ugt&order=myweight")
            
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return self.tabs = []//also notify app of failure as needed
                }
                
                let html = response.text!
                
                do {
                    // if encoding is omitted, it defaults to NSUTF8StringEncoding
                    let doc = try HTMLDocument(string: html, encoding: NSUTF8StringEncoding)
                    
                    var artist = ""
                    var title = ""
                    var url = ""
                    var i = 0
                    for row in doc.css(".tresults tr") { // for each row in table result
                        if i == 0 {
                            i += 1
                            continue
                        }
                        
                        
                        // Find artist
                        let artistColumn = row.css(".search_art") //
                        
                        if artistColumn.count > 0 {
                            artist = (artistColumn[0]?.stringValue)!
                        }
                        
                        // Find type
                        let type = row.children[3].stringValue
                        
                        if(type == "power tab" || type == "guitar pro" || type == "tab pro" || type == "video lesson") {
                            continue
                        }
                        print(type)
                        
                        // Find song og URL
                        let songTitleAndUrl = row.css(".result-link")
                        
                        if songTitleAndUrl.count > 0 {
                            //    print(songTitleAndUrl[0]?.stringValue) // song title
                            //    print(songTitleAndUrl[0]?["href"]) // song URL
                            title = (songTitleAndUrl[0]?.stringValue)!
                            url = (songTitleAndUrl[0]?["href"])!
                        }
                        
                        //print(artist.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
                        print()
                        
                        let tab = Tab()
                        tab.artist = artist.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) // trim out white space before and after
                        tab.title = title
                        tab.url = url
                        tab.type = type
                        
                        i += 1
                        
                        self.tabs.append(tab)
                        
                    }
                    
                } catch let error {
                    print(error)
                }
                
            }
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        return tabs
        
    }
    
    func hardProcessingWithString(input: String, completion: (result: String) -> Void) {
        
        completion(result: "we finished!")
    }
    
    func getTabContent(url :String) -> String {
        
        var tabContent = ""

        
        do {
            let opt = try HTTP.GET("\(url)")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                let html = response.text!
                
                    do {
                        // if encoding is omitted, it defaults to NSUTF8StringEncoding
                        let doc = try HTMLDocument(string: html, encoding: NSUTF8StringEncoding)
                        
                        
                        for link in doc.css(".js-tab-content") {
//                            print(link.stringValue)
//                            print()
                            
                            tabContent.appendContentsOf(link.stringValue)
                            
                        }
                        
                        return
                        
                    } catch let error {
                        print(error)
                    }
                
                
            }
        
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        sleep(1)
        
        print(tabContent)
        return tabContent
    }
    
}