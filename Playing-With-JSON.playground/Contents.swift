import UIKit

// JSON Data
let json = """
{
 "results": [
   {
     "firstName": "John",
     "lastName": "Appleseed"
   },
  {
    "firstName": "Alex",
    "lastName": "Paul"
  }
 ]
}
""".data(using: .utf8)!

//=======================================
// Create Model(s)
//=======================================
// Codable: Decodable & Encodable
// Decodable: converts json data
// Encodable: converts to json data to e.g POST to a Webn API

// Top Level JSON is a Dictionary
struct ResultsWrapper: Decodable {
    let results: [Contact]
}

struct Contact: Decodable {
    let firstName: String
    let lastName: String
}

//=======================================
// Create Model(s)
//=======================================

// Always go from the top level
do{
    let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: json)
    let contacts = dictionary.results
    dump(contacts)
} catch {
    print("decoding error: \(error)")
}
