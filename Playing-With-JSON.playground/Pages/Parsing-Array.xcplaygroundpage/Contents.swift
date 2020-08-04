//: [Previous](@previous)

import Foundation


let json = """
[
    {
        "title": "New York",
        "location_type": "City",
        "woeid": 2459115,
        "latt_long": "40.71455,-74.007118"
    }
]
""".data(using: .utf8)!

// Create model(s)
struct City: Codable {
    let title: String
    // reminder - once property names are changed
    // using CodingKeys, tehy must match identically to
    // the case type
   // let location_type: String
    
    let locationType: String
    
    
    let coordinate: String
    let woeid: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case coordinate = "latt_long"
    }
}



//===========================
// decode JSON to Swift Objects
//============================

do {
    let weatherArray = try JSONDecoder().decode([City].self, from: json)
    dump(weatherArray)
} catch {
    print("decoding error: \(error)")
}


//: [Next](@next)
