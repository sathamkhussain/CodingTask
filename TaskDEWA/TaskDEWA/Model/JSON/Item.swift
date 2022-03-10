/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import CoreLocation
struct Item : Codable {
	let id : String?
	let office : String?
	let lat : String?
	let lon : String?
	let loc : String?
    var distance : Double {
        return LocationManager.shared.calculateDistance(latitude: lat, longitude: lon)
    }
	enum CodingKeys: String, CodingKey {

		case id = "id"
		case office = "office"
		case lat = "lat"
		case lon = "lon"
		case loc = "loc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		office = try values.decodeIfPresent(String.self, forKey: .office)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		lon = try values.decodeIfPresent(String.self, forKey: .lon)
		loc = try values.decodeIfPresent(String.self, forKey: .loc)
	}

}
extension Double {
    func getKms() -> Double{
        return self / 1000
    }
}
