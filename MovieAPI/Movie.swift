//
//  Movie.swift
//  Movies
//
//  Created by Abdou Ett on 07/01/2017.
//  Copyright © 2017 Abdou Ett. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireImage

class TMDBMovie: NSObject {
    
    dynamic var image = NSImage()
    
    lazy var posterURL: String = {
        [unowned self] in
        let path = API.imageBaseURL.appending(self.posterPath)
        return path
        }()
    
    
    var posterPath = String()
    /*var backdropPath = String()
    var overview = String()
    var releaseDate = String()
    var genreIds = [NSNumber]()*/
    var id = NSNumber()
    /*var title = String()
    var popularity = NSNumber()
    var voteCount = NSNumber()
    var voteAverage = NSNumber()*/
    
    init(dict: NSDictionary) {
        super.init()
        self.posterPath   = dict["poster_path"] as? String ?? ""
        /*self.backdropPath = dict["backdrop_path"] as? String ?? ""
        self.overview     = dict["overview"] as? String ?? ""
        self.releaseDate  = dict["release_date"] as? String ?? ""
        self.genreIds     = dict["genre_ids"] as? [NSNumber] ?? [NSNumber]()*/
        self.id           = dict["id"] as? NSNumber ?? NSNumber()
        /*self.title        = dict["title"] as? String ?? String()
        self.popularity   = dict["popularity"] as? NSNumber ?? NSNumber()
        self.voteCount    = dict["vote_count"] as? NSNumber ?? NSNumber()
        self.voteAverage  = dict["vote_average"] as? NSNumber ?? NSNumber()*/
        
        self.getMovieImage(posterURL)
    }
    
    // Fetch movie poster image
    fileprivate func getMovieImage(_ imageURLString: String) {
        
        Alamofire.request(imageURLString).validate().responseImage { (dataResponse: DataResponse<Image>) in
            
            guard dataResponse.result.isSuccess else {
                debugPrint("Error fetching movie image: \(dataResponse.result.error)")
                return
            }
            
            if let image = dataResponse.result.value {
                self.image = image
            }
        }
    }
}
















