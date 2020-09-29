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

protocol ConsoleManagerViewController: class {
    
    func writeToDebugConsole( _ destinationText:String)
}

class ConsoleManager {
    
    static private var consoleWindowCtrl: NSWindowController? = nil
    static private var consoleViewCtrl: ConsoleViewController? = nil
  
    static public  var isActive: Bool {
        get { consoleWindowCtrl != nil }
    }
    static public  var isShowing: Bool {
        get { consoleWindowCtrl!.window!.isVisible == true }
    }
    
    static func setActive() {
        
        // External Entry: Initialze System / Turn It On - Must be Called in Application Init to Start System Working
        
        if consoleWindowCtrl == nil {
            
            let myStoryboard = NSStoryboard(name: "ConsoleView", bundle: nil)
            consoleWindowCtrl = myStoryboard.instantiateController(withIdentifier: "DebugWindow") as? NSWindowController
            
            guard consoleWindowCtrl != nil else {return}
            consoleViewCtrl = consoleWindowCtrl!.window!.contentViewController as? ConsoleViewController
        }
    }
    
    static func setInactive() {

        // External Entry: Disable System / Turn It Off

        if let myWindowController = consoleWindowCtrl {
            myWindowController.close()
            self.consoleWindowCtrl = nil
        }
    }
    
    static func toggleConsole() {
        
        // Hide / Show Console Window w/out Disabling System
        
        if self.isShowing == false { ConsoleManager.displayConsole() }
        else                       { ConsoleManager.hideConsole() }
    }
    
    static func displayConsole() {
        
        // External Entry: Show Console View, Activating if Necessary
        
        if consoleWindowCtrl == nil {ConsoleManager.setActive()}
        if let myWindowController = consoleWindowCtrl {
            myWindowController.showWindow(self)
        }
    }
    
    static func hideConsole(){

        // External Entry: Hide Console View, But Do Not Deactivate
        
        if let myWindowController = consoleWindowCtrl {
            myWindowController.window!.orderOut(self)
        }
    }
    
    static func printToConsole( _ output:String){
        
        // External Entry: Print to the Debug Console, w/out Printing to the System Console
        
        // TODO - Interesting connundrum here... do we put the write external or
        //        instead have it local and require a NSTextView reference in the Protocol?
        //        External allows the class to really do whatever the heck they want with
        //        the string (display, write to database, forward to another source)
        //        but putting the write here simplifies things binding wise (does it?)
        
        ConsoleManager.consoleViewCtrl!.writeToDebugConsole(output)
    }
}

