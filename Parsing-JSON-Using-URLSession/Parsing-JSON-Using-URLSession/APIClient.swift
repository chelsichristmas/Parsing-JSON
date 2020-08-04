//
//  APIClient.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Chelsi Christmas on 8/4/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation

// TODO: Convert to a Generic APIClient<Station>()

enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}
struct APIClient {
    
    // the fetchData() method does an asynchronous network call
    // this means the method returns (BEFORE) the request is complete
    
    // when delaing with asynchronous calls we use a closure
    // other methods you can use include: delegaation, NotificationCenter,
    // newer to iOS developers as of iOS 13 is (Combine)
    
    // closures capture values
    func fetchData(completion: @escaping (Result<[Station], AppError>) -> ()) {
        let endpoint = "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
            
            //.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        // This code added to the end of an appoint allows you to make queries that include spaces
        // i.e "prospect park"
        
        // 1.
        // we need a URL to create to create our network request
        guard let url = URL(string: endpoint)  else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        // 2. create a GET request, other request examples POST, DELETE, PATCH, PUT
         let request = URLRequest(url: url)
        
        // the request allows us to add/package more data
        // request.httpMethod = "GET" this is the default
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 3. use URLSession to make a Network Request
        // URLSession.shared is a singleton
        // this is sufficent to use for making most requests
        // using URLSession without the shared instance gives you access to adding necessary configurations to your task
        // You can use URL or URLRequest on the shared instance. You would use URLRequest if are using a request that isn't the default GET or if you need to add more values to your request
        
        let dataTask = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            if let data = data {
                // 4. decode the JSON to your Swift Model
                do {
                    
                    // You always put the top level of the model, but your result can be any aspect of the model
                    // For this example we're specifically interested int he array of CitiBike stations so the resu;t refers to model [Ststion]
                    let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    completion(.success(results.data.stations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
