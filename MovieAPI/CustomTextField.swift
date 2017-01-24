//
//  CustomTextField.swift
//  MovieAPI
//
//  Created by Abdou on 24/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

class HyperlinkTextField: NSTextField {

    override func resetCursorRects() {
        self.addCursorRect(self.bounds, cursor: NSCursor.pointingHand())
    }
    
    override func mouseDown(with event: NSEvent) {
       
        
    }
    
}














