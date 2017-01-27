//
//  Extensions.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

extension URLComponents {
    
    static func urlWithParameters( _ url: String, _ parameters: [String: Any]) -> URL! {
        guard var components = URLComponents(string: url) else {
            return nil
        }
        
        components.queryItems = parameters.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        guard let url = components.url else {
            return nil
        }
        
        return url
    }
}

extension NSImage {
    
    func resize(toSize size: NSSize) -> NSImage? {
        let destSize = size
        let newImage = NSImage(size: destSize)
        
        newImage.lockFocus()
        self.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, self.size.width, self.size.height), operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1), respectFlipped: false, hints: nil)
        
        newImage.unlockFocus()
        newImage.size = destSize
        
        guard let data = newImage.tiffRepresentation else {
            return nil
        }
        
        return NSImage(data: data)
    }
}

extension NSColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(calibratedRed: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    class var greyShade: NSColor {
        return NSColor(r: 29, g: 29, b: 29, a: 0.5)
    }
    
    class var gold: NSColor {
        return NSColor(r: 255, g: 215, b: 0, a: 1)
    }
    
    class var cadmiumOrange: NSColor {
        return NSColor(r: 248, g: 134, b: 45, a: 1)
    }
    
    class var galliano: NSColor {
        return NSColor(calibratedRed:0.84, green:0.65, blue:0.05, alpha:1.00)
    }
}

extension NSAttributedString {
    
    static func hyperlinkFromString(string:String, url:URL) -> NSAttributedString {
        // initially set viewable text
        let attrString = NSMutableAttributedString(string: string)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.beginEditing()
        // stack URL
        attrString.addAttribute(NSCursorAttributeName, value: NSCursor.arrow(), range: range)
        // stack text color
        attrString.addAttribute(NSForegroundColorAttributeName, value: NSColor.galliano, range: range)
        attrString.addAttribute(NSFontAttributeName, value: NSFont.init(name: "AvenirNext-Regular", size: 15.0) ?? NSFont(), range: range)
        attrString.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(value: Int32(NSUnderlineStyle.styleSingle.rawValue)), range: range)
        attrString.fixAttributes(in: range)
        attrString.fixFontAttribute(in: range)
        attrString.endEditing()
        return attrString
    }
}


extension NSFont {
    class func systemCustomFontOfSize(size: CGFloat) -> NSFont {
        return NSFont(name: "AlwynNew-Regular", size: size) ?? NSFont.systemFont(ofSize: size)
    }
    class func lightSystemFontOfSize(size: CGFloat) -> NSFont {
        return NSFont(name: "AlwynNew-Light", size: size) ?? NSFont.systemFont(ofSize: size)
    }
    class func boldSystemCustomFontOfSize(size: CGFloat) -> NSFont {
        return NSFont(name: "AlwynNew-Medium", size: size) ?? NSFont.boldSystemFont(ofSize: size)
    }
}
































