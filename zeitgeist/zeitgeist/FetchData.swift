//
//  FetchData.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 23.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation

class FetchData {
    let apiUrl = URL(string:"https://www.zalando-wardrobe.de/api/items?page=3n")
    
    var results: [SingleResult] = []
 
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetch()
//    }
 
    // Fetch data from API
    
    func fetch() {
        let urlRequest = URLRequest(url: apiUrl!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            self.results = [SingleResult]()
            do {
                // Parse JSON
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                
                if let resultsFromJSON = json?["items"] as? [[String: AnyObject]] {
                    for jsonData in resultsFromJSON {
                        let result = SingleResult()
                        if let brand = jsonData["brand"] as? String, let size = jsonData["size"] as? String, let condition = jsonData["condition"] as? String, let price = jsonData["price"] as? String
                        {
                            result.brand = brand
                            result.size = size
                            result.condition = condition
                            result.price = price
                        }
                        self.results.append(result)
                        print("DATA: \n \(result.brand) \n \(result.size) \n \(result.condition) \n \(result.price)")
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
}
