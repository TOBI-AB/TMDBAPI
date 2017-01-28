//
//  MovieDetailViewController+Extensions.swift
//  MovieAPI
//
//  Created by Abdou on 26/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

// MARK: - Helpers
extension MovieDetailViewController {
    
    // MARK: - Get Movie Videos
    func getMovieVideo(_ movieID: NSNumber) {
        let movieVideosURLString = Path.video.rawValue.replacingOccurrences(of: "{movie_id}", with: "\(movieID)")
        debugPrint(movieVideosURLString)
    }
    
    // MARK: - Fetch Movie Detail Data
    func getMovieDetail(_ movieID: NSNumber) {
        
        let baseURLString = API.APIbaseURL.appending(Path.detail.rawValue.replacingOccurrences(of: "{movie_id}", with: "\(movieID)"))
        let parameters = ["api_key": API.key, "language":movieLanguage.en] as [String : Any]
        
        guard let url = URLComponents.urlWithParameters(baseURLString, parameters) else {
            debugPrint("Invalid Movie Detail URL")
            return
        }

        // Network staff
        NetworkServer.shared.fetchAPIData(url) { [unowned self] (response: URLResponse?, data: Any?, error: Error?) in
            guard error == nil else {
                debugPrint("\(String(describing: error?.localizedDescription))")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: (data as? Data ?? Data()), options: []) as? NSDictionary else {
                return
            }
            self.movieDetail = TMDBMovieDetail(dict: json ?? NSDictionary(), delegate: self)
        }
    }
    
    // MARK: - Update View
    func updatView(_ movie: TMDBMovieDetail) {
        // debugPrint(movie.id)
        
        self.progressView.stopAnimation(self)
        
        // Movie Title
        self.view.window?.title = movie.title
        self.movieTitle = movie.title
        
        // Movie Overview
        let attributedMovieOverview = NSMutableAttributedString(string: "Synopsis".uppercased() + "\n", attributes: [NSFontAttributeName: NSFont.boldSystemCustomFontOfSize(size: 20.0), NSForegroundColorAttributeName: NSColor.galliano])
        
        let paragrapheStyle = NSMutableParagraphStyle()
        paragrapheStyle.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedMovieOverview.string.characters.count)
        attributedMovieOverview.addAttribute(NSParagraphStyleAttributeName, value: paragrapheStyle, range: range)
        attributedMovieOverview.append(NSAttributedString(string: movie.overview, attributes: [NSFontAttributeName: NSFont.systemCustomFontOfSize(size: 18.0)]))
        self.movieOverviewLabel.attributedStringValue = attributedMovieOverview
        
        // Movie Release Date
        self.movieReleaseDate = movie.releaseDate
        
        // Movie HomePage
        if !movie.homePage.isEmpty, let homePageURL = URL(string: movie.homePage) {
            homePageLabel.attributedStringValue = NSAttributedString.hyperlinkFromString(string: movie.homePage, url: homePageURL)
            self.homePageLabelHidding = false
        } else {
            self.homePageLabelHidding = true
        }
        
        // Movie Genres
        var tt = [String]()
        tt = movie.genres.enumerated().map {(key, dict) in
            let rr = String()
            return (rr + (dict["name"] as? String ?? ""))
        }
        self.movieGenres = tt.joined(separator: ", ")
        
        // Movie Vote Count
        let movieVote = "\(movie.voteAverage)/10 | ♡\(movie.voteCount)"
        let attributedText = NSMutableAttributedString(string: movieVote, attributes: [NSFontAttributeName: NSFont.systemCustomFontOfSize(size: 17), NSForegroundColorAttributeName: NSColor.galliano])
        self.voteLabel.alignment = .center
        self.voteLabel.attributedStringValue = attributedText
        
        // Movie Rating
        /*ratingLevelIndicator.maxValue = Double(round(movie.voteAverage.floatValue))
        ratingLevelIndicator.minValue = Double(0)
        ratingLevelIndicator.floatValue = movie.voteAverage.floatValue*/
        
    }
}

// MARK: - APIControllerProtocol
extension MovieDetailViewController: APIControllerProtocol {
    func didReceive(backgroundImage: NSImage?) {
        
        if let image = backgroundImage?.resize(toSize: view.frame.size) {
            self.backgroundImageView.image = image
            self.isHiding = false
        }
    }
}

// MARK: - Homepage link clicked
extension MovieDetailViewController: ClickableTextFieldDelegate {
    func textFieldClicked(textField: HyperlinkTextField) {
        guard let movieHomePageURL = URL(string: textField.stringValue) else { return }
        _ = try? NSWorkspace.shared().open(movieHomePageURL, options: .default, configuration: [:])
    }
}
