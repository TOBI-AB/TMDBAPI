//
//  MovieDetailViewController.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireImage

class MovieDetailViewController: NSViewController {
    
    @IBOutlet weak var customView: NSView!
    @IBOutlet weak var backgroundImageView: NSImageView!
    @IBOutlet weak var posterImageView: NSImageView!
    @IBOutlet weak var progressView: NSProgressIndicator!
    @IBOutlet weak var homePageLabel: NSTextField!
    
    // MARK: - Properties
    var movieDetail: TMDBMovieDetail?

    dynamic var movieTitle: String?
    dynamic var movieOverview: String?
    dynamic var movieGenres: String?
    dynamic var movieHomePage: String?
    dynamic var movieReleaseDate: String?
    dynamic var isHiding = true
    dynamic var cadmiumOrangeColor = NSColor.cadmiumOrange
    
    // New selected Movie
    var selectedMovie: TMDBMovieDetail? {
        didSet {
            if let movie = selectedMovie {
                OperationQueue.main.addOperation {
                    self.updatView(movie)
                }
            }
        }
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.wantsLayer = true
        customView.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.80).cgColor
        
        // Make subviews background no transparent
        _ = view.subviews.map {
            ($0 as? NSTextField)?.wantsLayer = true
            ($0 as? NSTextField)?.alphaValue = 1.0
            ($0 as? NSStackView)?.wantsLayer = true
            ($0 as? NSStackView)?.alphaValue = 1.0
            ($0 as? NSImageView)?.wantsLayer = true
            ($0 as? NSImageView)?.alphaValue = 0.8
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidAppear() {
        super.viewDidAppear()
        self.progressView.startAnimation(self)
    }
    
    override var representedObject: Any? {
        didSet {
            if let movie = representedObject as? TMDBMovie {
                self.getMovieDetail(movie.id)
                self.posterImageView.image = movie.image
            }
        }
    }
}


// MARK: - Helpers
extension MovieDetailViewController {
    ///movie/{movie_id}
    
    func getMovieDetail(_ movieID: NSNumber) {
        
        let baseURLString = API.APIbaseURL.appending(Path.detail.rawValue.replacingOccurrences(of: "{movie_id}", with: "\(movieID)"))
        let parameters = ["api_key": API.key, "language":movieLanguage.fr] as [String : Any]
        
        guard let url = URLComponents.urlWithParameters(baseURLString, parameters) else {
            debugPrint("Invalid Movie Detail URL")
            return
        }
        NetworkServer.shared.fetchAPIData(url) { [unowned self] (response: URLResponse?, data: Any?, error: Error?) in
            guard error == nil else {
                debugPrint("\(error?.localizedDescription)")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: (data as? Data ?? Data()), options: []) as? NSDictionary else {
                return
            }
            self.selectedMovie = TMDBMovieDetail(dict: json ?? NSDictionary(), delegate: self)
        }
    }
    
    // Update View
    fileprivate func updatView(_ movie: TMDBMovieDetail) {
        debugPrint(movie.id)
        
        self.progressView.stopAnimation(self)
      
        // Movie Title
        self.view.window?.title = movie.title
        self.movieTitle = movie.title
        
        // Movie Overview
        self.movieOverview = "SYNOPSIS :" + "\n" + movie.overview
        
        // Movie Release Date
        self.movieReleaseDate = movie.releaseDate
        
        // Movie HomePage
        if !movie.homePage.isEmpty, let homePageURL = URL(string: movie.homePage) {
            homePageLabel.attributedStringValue = NSAttributedString.hyperlinkFromString(string: movie.homePage, url: homePageURL)
        } else {
            homePageLabel.stringValue = ""
        }
        
        // Movie Genres
        var tt = [String]()
        tt = movie.genres.enumerated().map {(key, dict) in
            let rr = String()
            return (rr + (dict["name"] as? String ?? ""))
        }
        self.movieGenres = tt.joined(separator: ", ")
        
    }
}

// MARK: - APIControllerProtocol
extension MovieDetailViewController: APIControllerProtocol {
    
    func didReceiveAPIResults(backgroundPath: String) {
        Alamofire.request(backgroundPath).validate().responseImage { (dataResponse: DataResponse<Image>) in
            
            guard dataResponse.result.isSuccess else {
                debugPrint("Error fetching movie image: \(dataResponse.result.error)")
                return
            }
            
            if let image = dataResponse.result.value {
                let image = image.resize(toSize: self.view.frame.size)
                self.backgroundImageView.image = image
                self.isHiding = false
            }
        }
    }
}






































