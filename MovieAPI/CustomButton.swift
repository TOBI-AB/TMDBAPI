//
//  CustomButton.swift
//  MovieAPI
//
//  Created by Abdou on 25/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

class CustomButton: NSButton {
    
    var customAttributedTitle: NSAttributedString {
        let titleAttributes = [NSForegroundColorAttributeName: NSColor.white,
                               NSFontAttributeName: NSFont.systemCustomFontOfSize(size: 14.0)]
        
        let attributedTitle = NSMutableAttributedString(attributedString: self.attributedTitle)
        let attributedTitleRange = NSMakeRange(0, attributedTitle.length)
        attributedTitle.addAttributes(titleAttributes, range: attributedTitleRange)
        attributedTitle.fixAttributes(in: attributedTitleRange)
        return attributedTitle
    }
    
    override func awakeFromNib() {
        self.attributedTitle = customAttributedTitle
        self.sizeToFit()
    }
    override var wantsUpdateLayer: Bool {
        return true
    }
    override func updateLayer() {
       // self.layer?.cornerRadius = 5.0
        self.layer?.borderColor = NSColor.cadmiumOrange.cgColor
        self.layer?.borderWidth = 1.5
       //NSColor(white: 0.2, alpha: 0.5).cgColor
        
        if let cell = self.cell {
            if cell.isHighlighted {
                self.layer?.backgroundColor = NSColor(white: 0.1, alpha: 0.9).cgColor
            } else {
                self.layer?.backgroundColor = NSColor.clear.cgColor
            }
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        self.layer?.backgroundColor = NSColor.black.cgColor
    }
    override func mouseExited(with event: NSEvent) {
         self.layer?.backgroundColor = NSColor.clear.cgColor
    }
}











