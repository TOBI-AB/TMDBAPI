//
//  WindowController.swift
//  MovieAPI
//
//  Created by Abdou on 26/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.setFrame(NSRect(origin: CGPoint.zero, size: CGSize(width: 1920, height: 1200)), display: true)
    }

}
