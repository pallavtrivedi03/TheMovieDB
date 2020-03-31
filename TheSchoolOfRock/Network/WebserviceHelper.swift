//
//  WebserviceHelper.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 28/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import Foundation

class WebserviceHelper {
    
    private let queue = OperationQueue()
    
    var session: FakeURLSession = URLSession(configuration: URLSessionConfiguration.default)
    func fetchResponse(url: URL, shouldCancelOtherOps: Bool, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        if shouldCancelOtherOps {
            queue.cancelAllOperations()
        }
        
        let fetchOperation = BlockOperation { [weak self] in
            let dataTask = self?.session.dataTask(with: url) { (data, response, error) in
                completion(data, response, error)
            }
            dataTask?.resume()
        }
        queue.addOperation(fetchOperation)
    }
    
}
