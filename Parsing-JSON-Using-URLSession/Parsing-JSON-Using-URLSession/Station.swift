//
//  Station.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Chelsi Christmas on 8/4/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation

// review Float vs Double: Double holds more floatiing points than a Float
struct ResultsWrapper: Decodable {
    let data: StationsWrapper
}

struct StationsWrapper: Decodable {
    let stations: [Station]
}

struct Station: Decodable, Hashable {
    let name: String
    let stationType: String
    let latitude: Double
    let longitude: Double
    let capacity: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stationType = "station_type"
        case latitude = "lat"
        case longitude = "lon"
        case capacity
    }
}
