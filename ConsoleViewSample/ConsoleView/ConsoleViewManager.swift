//
//  ConsoleViewManager.swift
//
//  Created by JC Nolan on 9/28/20.
//  Copyright © 2020 JC Nolan. All rights reserved.
//

import Foundation
import Cocoa

// External Entry: Ties into Regualar Swift.print() to Echo Everything Printed to System Console to the Debug Console
// Print Hook from - https://stackoverflow.com/questions/39026752/swift-extending-functionality-of-print-function

public func print(_ items: String..., filename: String = #file, function : String = #function,
                  line: Int = #line, separator: String = " ", terminator: String = "\n")
{
    let output = items.map { "\($0)" }.joined(separator: separator)
    
    if ConsoleManager.isActive {
        ConsoleManager.printToConsole(output+terminator)
    }
    
    Swift.print(output, terminator: terminator)
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
{
    let output = items.map { "\($0)" }.joined(separator: separator)
    
    if ConsoleManager.isActive {
        ConsoleManager.printToConsole(output+terminator)
    }
    
    Swift.print(output, terminator: terminator)
}

/// -------------------------------------------------------------------------------------------------

class ConsoleManager {
    
    static private var myWindowController: NSWindowController? = nil
    static private var consoleTextView: NSTextView? = nil
    static private var consoleView: ConsoleViewController? = nil
  
    static public  var isActive: Bool {
        get { myWindowController != nil }
    }
    static public  var isShowing: Bool {
        get { myWindowController!.window!.isVisible == true }
    }
    
    static func setActive() {
        
        // External Entry: Initialze System / Turn It On - Must be Called in Application Init to Start System Working
        
        if myWindowController == nil {
            
            let myStoryboard = NSStoryboard(name: "ConsoleView", bundle: nil)
            myWindowController = myStoryboard.instantiateController(withIdentifier: "DebugWindow") as? NSWindowController
            
            guard myWindowController != nil else {return}
            consoleView = myWindowController!.window!.contentViewController as? ConsoleViewController
            
            guard consoleView != nil else {return}
            consoleTextView = consoleView!.consoleTextView
        }
    }
    
    static func setInactive() {

        // External Entry: Disable System / Turn It Off

        if let myWindowController = myWindowController {
            myWindowController.close()
            self.myWindowController = nil
        }
    }
    
    static func toggleConsole() {
        
        // Hide / Show Console Window w/out Disabling System
        
        if self.isShowing == false { ConsoleManager.displayConsole() }
        else                       { ConsoleManager.hideConsole() }
    }
    
    static func displayConsole() {
        
        // External Entry: Show Console View, Activating if Necessary
        
        if myWindowController == nil {ConsoleManager.setActive()}
        if let myWindowController = myWindowController {
            myWindowController.showWindow(self)
        }
    }
    
    static func hideConsole(){

        // External Entry: Hide Console View, But Do Not Deactivate
        
        if let myWindowController = myWindowController {
            myWindowController.window!.orderOut(self)
        }
    }
    
    static func printToConsole( _ output:String){
        
        // External Entry: Print to the Debug Console, w/out Printing to the System Console
        
        ConsoleManager.consoleView!.writeToDebugConsole(output)
    }
}

