//
//  MovieDetail.swift
//  MovieAPI
//
//  Created by Abdou on 22/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

protocol APIControllerProtocol {
    func didReceiveAPIResults(backgroundPath: String)
}

class TMDBMovieDetail: NSObject {
    
    var budget              = NSNumber()
    var genres              = [NSDictionary]()
    var homePage            = String()
    var id                  = NSNumber()
    var overview            = String()
    var proudctionCompanies = [NSDictionary]()
    var productionCountries = [NSDictionary]()
    var releaseDate         = String()
    var revenue             = NSNumber()
    var runtime             = NSNumber()
    var spokenLanguages     = [NSDictionary]()
    var title               = String()
    var voteAverage         = NSNumber()
    var voteCount           = NSNumber()
    
    
    lazy var backgroundPath = String()
    var delegate: APIControllerProtocol?
    
    override init() {
        super.init()
    }
    
    convenience init?(dict: NSDictionary, delegate: APIControllerProtocol) {
        self.init()
        self.delegate = delegate
        self.budget = dict["budget"] as? NSNumber ?? NSNumber()
        self.genres = dict["genres"] as? [NSDictionary] ?? [NSDictionary]()
        self.homePage = dict["homepage"] as? String ?? ""
        self.id       = dict["id"] as? NSNumber ?? NSNumber()
        self.overview = dict["overview"] as? String ?? ""
        self.proudctionCompanies    = dict["production_companies"] as? [NSDictionary] ?? [NSDictionary]()
        self.productionCountries = dict["production_countries"] as? [NSDictionary] ?? [NSDictionary]()
        self.releaseDate = dict["release_date"] as? String ?? ""
        self.revenue = dict["revenue"] as? NSNumber ?? NSNumber()
        self.runtime = dict["runtime"] as? NSNumber ?? NSNumber()
        self.spokenLanguages = dict["spokenLanguages"] as? [NSDictionary] ?? [NSDictionary]()
        self.title = dict["title"] as? String ?? ""
        self.voteAverage = dict["vote_average"] as? NSNumber ?? NSNumber()
        self.voteCount = dict["vote_count"] as? NSNumber ?? NSNumber()
        
        getMovieDetail(self.id)
    }
    
    // Make movie background image request
    fileprivate func getMovieDetail(_ movieID: NSNumber) {
        let requestURLString = FanartWebService.baseURL.appending("\(movieID)")
        let parameters = ["api_key": FanartWebService.apiKey]
        guard let requestURL = URLComponents.urlWithParameters(requestURLString, parameters) else {
            return
        }
        
        NetworkServer.shared.fetchAPIData(requestURL) { (response: URLResponse?, data: Any?, error: Error?) in
            guard (error == nil) else {
                debugPrint("error --> back movie: \(error?.localizedDescription)")
                return
            }
            
            guard let data = data as? Data else {
                debugPrint("no data returned from FanartService")
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary, let moviebackgroundDict =  json["moviebackground"] as? [NSDictionary] else {
                    return
                }
                
                if let backgroundPath = moviebackgroundDict[0].value(forKey: "url") as? String {
                    if let delegate = self.delegate {
                        delegate.didReceiveAPIResults(backgroundPath: backgroundPath)
                    }
                }
                
            } catch let error {
                debugPrint("error parsing json back movie: \(error)")
            }
        }
    }
}
































































































