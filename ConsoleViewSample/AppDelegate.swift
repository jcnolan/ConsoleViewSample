//
//  AppDelegate.swift
//  ConsoleViewSample
//
//  Created by JC Nolan on 9/28/20.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Insert code here to initialize your application
        
        // Activate debug console
        
        ConsoleManager.setActive() // Initialize Console Print System
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        
        // Insert code here to tear down your application
        
        ConsoleManager.setInactive() // Tear Down Console Print System, otherwise window state is not saved on exit
    }
 
    @IBAction func toggleConsoleView(_ sender: Any) {
        ConsoleManager.toggleConsole()
    }

}

