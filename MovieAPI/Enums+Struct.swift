//
//  Enums+Struct.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Foundation

struct API {
    static let APIbaseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
    static let key = "34a6e67e97fb89c85a8364c28f65fdc2"
}

enum Path: String {
    case discover = "/discover/movie"
    case search   = "/find/{external_id}"
    case genre    = "/genre/movie/list"
    case detail   = "/movie/{movie_id}"
}

struct FanartWebService {
    static let apiKey = "fed36e757b61ceb1096bac206d4ce4a5"
    static let baseURL = "https://webservice.fanart.tv/v3/movies/"
}

enum movieLanguage: String {
    case fr = "fr-FR"
    case en = "en-US"
}
