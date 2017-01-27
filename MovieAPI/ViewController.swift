//
//  ViewController.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    // MARK: - Properties
    fileprivate var openController: NSWindowController?
    fileprivate var movies = [TMDBMovie]()
    fileprivate var page: Int = 1
   
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMoviesAtPage(self.page)
        setupCollectionView()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
    }
    
    // MARK: Fetching & Parsing Movie Data
    fileprivate func fetchMoviesAtPage(_ page: Int) {
        let parameters = ["api_key": API.key, "page": page, "sort_by": "popularity.desc"] as [String: Any]
        let basicURL = API.APIbaseURL.appending(Path.discover.rawValue)

        guard let requestURLString = URLComponents.urlWithParameters(basicURL, parameters) else {
            debugPrint("Invalid Request URL")
            return
        }
        var tempArray = [TMDBMovie]()

        // Network staff
        NetworkServer.shared.fetchAPIData(requestURLString) { [unowned self] (response: URLResponse?, data: Any?, error: Error?) in
            
            guard error == nil else {
                debugPrint("\(String(describing: error?.localizedDescription))")
                return
            }
            guard let data = data as? Data else {
                debugPrint("no data returned")
                return
            }
            // Parsing JSON
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary, let results = json["results"] as? [NSDictionary] {
                    tempArray = results.map { return TMDBMovie(dict: $0) }
                    
                    OperationQueue.main.addOperation {
                        self.movies.append(contentsOf: tempArray)
                        self.collectionView.reloadData()
                    }
                }
            } catch {
                debugPrint("Error parsing json: \(error.localizedDescription)")
            }
            
        }
    }
    
}


// MARK: - CollectionView Datasource
extension ViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath)
        item.representedObject = movies[indexPath.item]
        return item
    }
    
}

// MARK: - CollectionView Delegate
extension ViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, willDisplay item: NSCollectionViewItem, forRepresentedObjectAt indexPath: IndexPath) {
      
        if (indexPath.item == movies.count - 1) && 1..<1000 ~= self.page {
            self.page += 1
            self.fetchMoviesAtPage(page)
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        if let indexPath = indexPaths.first {
            let selectedMovie = movies[indexPath.item]
            
            if let movieDetailWindowController = storyboard?.instantiateController(withIdentifier: "DetailWindow") as? NSWindowController, let movieDetailViewController = movieDetailWindowController.contentViewController as? MovieDetailViewController  {
                movieDetailViewController.representedObject = selectedMovie
                movieDetailWindowController.showWindow(selectedMovie)
                self.openController = movieDetailWindowController
            }
        }
    }
}

// MARK: - Methods
extension ViewController {
    fileprivate func setupCollectionView() {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.sectionInset = EdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkGray.cgColor
        collectionView.layer?.backgroundColor = NSColor.darkGray.cgColor
        collectionView.isSelectable = true
    }
}















































