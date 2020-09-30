//
//  ViewController.swift
//  ConsoleViewSample
//
//  Created by JC Nolan on 9/28/20.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var testerText: NSTextField!
    
    @IBAction func testPrint(_ sender: Any) {
        
        let textToPrint = testerText.stringValue
        print(textToPrint)
    }
    @IBAction func toggleConsole(_ sender: Any) {
        ConsoleManager.toggleConsole()
    }
    
    @IBAction func testExit(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Does printing to console work?")
        
        ConsoleManager.setActive() // Initialize Console Print System
        
        print("Does printing to console work now?")
        print("Yeah Baby!")
        
        Swift.print("But this one still prints only in the system console...")
    }

}


