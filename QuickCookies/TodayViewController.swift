//
//  TodayViewController.swift
//  QuickCookies
//
//  Created by Justin Loew on 4/9/15.
//  Copyright (c) 2015 Lustin' Joew. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
	
	/// The String used to save the number of cookies Grandma's churned out.
	private let numCookiesKey = "numCookies"
        
	@IBOutlet weak var cookies: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
		cookies.text = getCookies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
		bakeCookies()

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
	
	/// Mmm, smells good.
	func bakeCookies() {
		cookies.text! += "🍪🍪"
		// if we eat too many cookies we'll get sick!
		if count(cookies.text!) > 24 {
			cookies.text = "🍪"
		}
		
		saveCookies()
	}
	
	/// Save the number of cookies grandma's baked. If our app is reloaded, granny won't lose her cookie arsenal.
	func saveCookies() {
		let numCookies = count(cookies.text!)
		
		let defaults = NSUserDefaults.standardUserDefaults()
		defaults.setInteger(numCookies, forKey: numCookiesKey) // saved!
	}
	
	/// Load the saved cookies.
	func getCookies() -> String {
		let defaults = NSUserDefaults.standardUserDefaults()
		// if we've never saved the number of cookies (e.g., first launch), this returns 0
		var numCookies = defaults.integerForKey(numCookiesKey)
		if numCookies == 0 {
			numCookies = 1
		}
		
		var cookieStr = ""
		for _ in 0 ..< numCookies { // The _ says that we don't want to use the variable that counts from 0 to numCookies.
			cookieStr += "🍪"
		}
		
		return cookieStr
	}
    
}
