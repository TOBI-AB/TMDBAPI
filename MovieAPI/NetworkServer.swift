//
//  NetworkServer.swift
//  MovieAPI
//
//  Created by Abdou on 21/01/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Foundation


class NetworkServer: NSObject {
    
    static let shared = NetworkServer()
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 30.0
        config.isDiscretionary = false
        let session = URLSession(configuration: config)
        return session
    }()
    
    override init() {
        super.init()
    }
    
    func fetchAPIData(_ dataURL: URL, completion:@escaping (_ response: URLResponse?, _ data: Any?, _ error: Error?) -> Void) {
        
        let task = session.dataTask(with: dataURL) { (data: Data?, response: URLResponse?, error: Error?) in
            
             guard (error == nil) else {
                completion(response, nil, error)
                return
            }
            
            guard let requestResponse = (response as? HTTPURLResponse), 200..<299 ~= requestResponse.statusCode else {
                debugPrint("Status code: \( (response as? HTTPURLResponse)?.statusCode)")
                return
            }
            
            if let data = data {
                completion(response, data, nil)
            }
        }
        task.resume()
    }
    
}






























