//
//  MyCustomSwiftAnimator.swift
//  NSViewControllerPresentations
//
//  Created by jonathan on 25/01/2015.
//  Copyright (c) 2015 net.ellipsis. All rights reserved.
//
//  based on:
//  http://stackoverflow.com/questions/26715636/animate-custom-presentation-of-viewcontroller-in-os-x-yosemite

import Cocoa

class Animator: NSObject, NSViewControllerPresentationAnimator {
    
     func  animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        let bottomVC = fromViewController
        let topVC = viewController
      
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        topVC.view.layer?.backgroundColor = NSColor.galliano.cgColor
        topVC.view.translateOrigin(to: NSPoint(x: bottomVC.view.frame.width, y: 0))
        bottomVC.view.addSubview(topVC.view)
        //bottomVC.view.frame
       
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.5
           // topVC.view.translateOrigin(to: NSPoint.zero)
            topVC.view.frame = NSRect(origin: CGPoint.init(x: bottomVC.view.frame.width - 200, y: 0), size: CGSize(width: 200, height: bottomVC.view.frame.height))
        }, completionHandler: nil)
        
    }
    
    
    func  animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 2
            topVC.view.animator().alphaValue = 0
        }, completionHandler: {
            topVC.view.removeFromSuperview()
        })
    }
    
}
