//
//  Enums+Struct.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Foundation
import Cocoa

// MARK: - Enums

enum ImageResolution {
    case w500
    case w1280
}

enum Path: String {
    case discover        = "/discover/movie"
    case nowPlaying      = "/movie/now_playing"
    case latset          = "/movie/latest"
    case search          = "/find/{external_id}"
    case genre           = "/genre/movie/list"
    case detail          = "/movie/{movie_id}"
    case video           = "/movie/{movie_id}/videos"
    case imdb            = "http://www.imdb.com/title"
    case youtubeTrailler = "https://www.youtube.com/watch?v="
}

enum movieLanguage: String {
    case fr = "fr-FR"
    case en = "en-US"
}

enum CustomFonts {
    enum AlwynNewFont: String {
        case medium  = "AlwynNew-Medium"
        case regular = "AlwynNew-Regular"
        case light   = "AlwynNew-Light"
    }
    
    enum AvenirNext: String {
        case medium  = "AvenirNext-Medium"
        case regular = "AvenirNext-Regular"
    }
}

// MARK: - Structs
struct API {
    static let APIbaseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/\(ImageResolution.w500)"
    static let key = "34a6e67e97fb89c85a8364c28f65fdc2"
}

struct FanartWebService {
    static let apiKey = "fed36e757b61ceb1096bac206d4ce4a5"
    static let baseURL = "https://webservice.fanart.tv/v3/movies/"
}




































