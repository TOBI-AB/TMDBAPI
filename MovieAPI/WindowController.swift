//
//  WindowController.swift
//  MovieAPI
//
//  Created by Abdou on 26/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

class MovieWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.setFrame(NSRect(origin: CGPoint.zero, size: CGSize(width: 1920, height: 1200)), display: true)
    }

}

class MovieDetailWindowController: NSWindowController {
   
    override func windowDidLoad() {
        super.windowDidLoad()
        
        guard let screen =  NSScreen.main(), let window = self.window else {
            return
        }
        
        let center = NSPoint(x: (screen.visibleFrame.size.width - window.frame.size.width)/2, y: (screen.visibleFrame.size.height - window.frame.size.height)/2)
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        window.setFrame(NSRect(origin: center, size: CGSize(width: 1280, height: 720)), display: true)
    }
}






