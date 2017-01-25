//
//  Enums+Struct.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Foundation
import Cocoa

struct API {
    static let APIbaseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w1280"
    static let key = "34a6e67e97fb89c85a8364c28f65fdc2"
}

enum Path: String {
    case discover   = "/discover/movie"
    case nowPlaying = "/movie/now_playing"
    case latset     = "/movie/latest"
    case search     = "/find/{external_id}"
    case genre      = "/genre/movie/list"
    case detail     = "/movie/{movie_id}"
    case video      = "/movie/{movie_id}/videos"
}

struct FanartWebService {
    static let apiKey = "fed36e757b61ceb1096bac206d4ce4a5"
    static let baseURL = "https://webservice.fanart.tv/v3/movies/"
}

enum movieLanguage: String {
    case fr = "fr-FR"
    case en = "en-US"
}

enum AlwynNewFont: String {
    
    case Medium  = "AlwynNew-Medium"
    case Regular = "AlwynNew-Regular"
    case Light   = "AlwynNew-Light"
    
    var fontType: NSFont {
        
        switch self {
        case .Medium:
            return NSFont(name: self.rawValue, size: 17.0) ?? NSFont.boldSystemFont(ofSize: 16.0)
        case .Regular:
            return NSFont(name: self.rawValue, size: 15.0) ?? NSFont.systemFont(ofSize: 15.0)
        case .Light:
            return NSFont(name: self.rawValue, size: 13.0) ?? NSFont.systemFont(ofSize: 13.0)
        }
    }
}






































