//
//  Video.swift
//  MovieAPI
//
//  Created by Abdou on 26/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Foundation

class Video: NSObject {
    
    var id = String()
    var key = String()
    var name = String()
    var site = String()
    var size = NSNumber()
    var type = String()
    
    init(dict: NSDictionary) {
        self.id = dict["id"] as? String ?? ""
        self.key = dict["key"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.site = dict["site"] as? String ?? ""
        self.size = dict["size"] as? NSNumber ?? NSNumber()
        self.type = dict["tye"] as? String ?? ""
    }
}






