//
//  ConsoleViewController.swift
//  MMAutoPost
//
//  Created by JC Nolan on 9/22/20.
//  Copyright © 2020 JC Nolan. All rights reserved.
//

import Cocoa

class ConsoleViewController: NSViewController, ConsoleManagerViewController {

    @IBOutlet weak var consoleScrollView: NSScrollView!
    @IBOutlet weak var consoleTextView: NSTextView!
    
    override func viewDidLoad() {
        
        // Set font programatically because an editable text view does not seem to let you set the font :(
        
        if let font = NSFont(name: "Courier", size: 14) {
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            consoleTextView.typingAttributes = attributes as! [NSAttributedString.Key : Any]
            consoleTextView.textColor = .white
        }
    }
    
    public func writeToDebugConsole( _ destinationText:String)  { consoleScrollView.documentView!.insertText(destinationText) }
    
    @IBAction func clear(_ sender: Any)                         { consoleTextView.string = "" }
    @IBAction func cancel(_ sender: Any)                        { ConsoleManager.hideConsole() }
}
