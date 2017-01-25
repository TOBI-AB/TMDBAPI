//
//  CustomTextField.swift
//  MovieAPI
//
//  Created by Abdou on 24/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

protocol ClickableTextFieldDelegate {
    func textFieldClicked(textField: HyperlinkTextField)
}

class HyperlinkTextField: NSTextField {
    
    var clickableTextFieldDelegate: ClickableTextFieldDelegate? = nil

    override func resetCursorRects() {
        self.addCursorRect(self.bounds, cursor: NSCursor.pointingHand())
    }
    
    override func mouseDown(with event: NSEvent) {
        self.clickableTextFieldDelegate?.textFieldClicked(textField: self)
    }
}














