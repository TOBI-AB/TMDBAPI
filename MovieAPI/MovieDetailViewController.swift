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
    @IBOutlet weak var ratingLevelIndicator: NSLevelIndicator!
    @IBOutlet weak var homePageLabel: HyperlinkTextField!
    @IBOutlet weak var movieOverviewLabel: NSTextField!
    @IBOutlet weak var voteLabel: NSTextField!
    
    
    
    // MARK: - Properties

    dynamic var movieTitle: String?
    dynamic var movieGenres: String?
    dynamic var movieHomePage: String?
    dynamic var movieReleaseDate: String?
    dynamic var movieVoteAverage: String?
    dynamic var movieVoteCount: String?
    dynamic var isHiding = true
    dynamic var homePageLabelHidding = false
    dynamic var cadmiumOrangeColor = NSColor.cadmiumOrange
    dynamic var gallianoColor      = NSColor.galliano
    
    lazy var movieID = NSNumber()

    var movieDetail: TMDBMovieDetail? {
        didSet {
            if let movie = movieDetail {
                OperationQueue.main.addOperation {
                    self.updatView(movie)
                    self.movieID = movie.id
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MovieID"), object: nil, userInfo: ["movieID": movie.id])
                }
            }
        }
    }
    
   
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.wantsLayer = true
        customView.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        
        // Make subviews background no transparent
        _ = view.subviews.map {
            ($0 as? NSTextField)?.wantsLayer = true
            ($0 as? NSTextField)?.alphaValue = 1.0
            ($0 as? NSStackView)?.wantsLayer = true
            ($0 as? NSStackView)?.alphaValue = 1.0
            ($0 as? NSImageView)?.wantsLayer = true
            ($0 as? NSImageView)?.alphaValue = 0.8
        }
        
        // Make MovieDetailViewController Delegate to Homepagelabel to handle homepage URLS
        self.homePageLabel.clickableTextFieldDelegate = self
        
       
    }
    
    // MARK: - View Life Cycle
    override func viewDidAppear() {
        super.viewDidAppear()
        self.progressView.startAnimation(self)
    }
    
    override var representedObject: Any? {
        didSet {
            if let movie = representedObject as? TMDBMovie {
                self.movieID = movie.id
                self.getMovieDetail(movie.id)
                self.posterImageView.image = movie.image

            }
        }
    }
    
    // Show more details in IMDB
    @IBAction func imdbDetailClicked(_ sender: CustomButton) {
        
        if let movieDetail = self.movieDetail, let imdbURL = URL(string: Path.imdb.rawValue) {
            let url = imdbURL.appendingPathComponent(movieDetail.imdbID)
            _ = try? NSWorkspace.shared().open(url, options: .default, configuration: [:])
        }
    }
    
    @IBAction func showTraillerViewController(_ sender: CustomButton) {
        
        if let videosViewCotroller = storyboard?.instantiateController(withIdentifier: "VideoMovieVC") as? MovieVideosViewController {
            videosViewCotroller.representedObject = self.representedObject
            self.presentViewController(videosViewCotroller, animator: Animator())
            
        }
    }
    
}







































