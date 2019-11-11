//
//  ViewControler.swift
//  Switcher
//
//  Created by Michał Grabowski on 11/11/2019.
//  Copyright © 2019 Michał Grabowski. All rights reserved.
//

import Cocoa

class ViewControler: NSViewController {    
    @IBOutlet weak var showNextTime: NSButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSApplication.shared.mainWindow?.close()
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
//        let defaults = UserDefaults.standard
//        let x = defaults.object(forKey: "hideWindow")
//        if x as? String == "Yes" {
            
//        }
        
        
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        let defaults = UserDefaults.standard
        if showNextTime.stringValue == "0" {
            defaults.set("Yes", forKey:"hideWindow")
            defaults.synchronize()
        }
        
        view.window?.close()
    }
}
