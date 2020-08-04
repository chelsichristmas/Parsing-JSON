//
//  President.swift
//  Parsing-JSON-Using-Bundle
//
//  Created by Chelsi Christmas on 8/3/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation

struct President: Decodable, Hashable {
    let number: Int
    let name: String // originally called "president"
    let birthYear: Int
    let deathYear: Int?
    let tookOffice: String
    let leftOffice: String?
    let party: String
    
    private enum CodingKeys: String, CodingKey {
        case number
        case name = "president"
        case birthYear = "birth_year"
        case deathYear = "death_year"
        case tookOffice = "took_office"
        case leftOffice = "left_office"
        case party
    }
}



