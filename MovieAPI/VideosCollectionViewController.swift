//
//  VideosCollectionViewController.swift
//  MovieAPI
//
//  Created by Abdou on 26/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

class MovieVideosViewController: NSViewController {
    
    @IBOutlet weak var movieVideosCollectionView: NSCollectionView!
    
    var movieVideos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        setupCollectionView()
    }
    
    override var representedObject: Any? {
        didSet {
            if let movie = representedObject as? TMDBMovie {
                self.getMovieVideos(movie.id)
            }
        }
    }
}

extension MovieVideosViewController {
    func getMovieVideos(_ movieID: NSNumber) {

        let urlString = API.APIbaseURL.appending(Path.video.rawValue.replacingOccurrences(of: "{movie_id}", with: "\(movieID)"))
        let parameters = ["api_key": API.key]
        
        guard let url = URLComponents.urlWithParameters(urlString, parameters) else {
            debugPrint("Invalide Videos URL")
            return
        }
        // Network Staff
        NetworkServer.shared.fetchAPIData(url) { (_, data: Any?, error: Error?) in
            guard error == nil else {
                debugPrint("\(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let data = data as? Data else {
                debugPrint("No videos data")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary, let results = json["results"] as? [NSDictionary] else {
                    debugPrint("Error parsing videos json")
                    return
                }
                self.movieVideos = results.map { return Video(dict: $0) }
                OperationQueue.main.addOperation {
                    self.movieVideosCollectionView.reloadData()
                }
                
            } catch {
                debugPrint("\(error.localizedDescription)")
            }
            
        }
    }
}

extension MovieVideosViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieVideos.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "VideoCollectionViewItem", for: indexPath)
        let movieVideo = self.movieVideos[indexPath.item]
        item.representedObject = movieVideo
        return item
    }
}

// MARK: - CollectionView Flow layout
extension MovieVideosViewController {
    fileprivate func setupCollectionView() {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 180)
        layout.sectionInset = EdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumInteritemSpacing = 10
        movieVideosCollectionView.collectionViewLayout = layout
        movieVideosCollectionView.isSelectable = true
    }
}






























