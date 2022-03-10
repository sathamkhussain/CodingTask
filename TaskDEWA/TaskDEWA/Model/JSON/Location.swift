//
//  Location.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/8/22.
//

import Foundation
struct Location : Codable {
    let locationsApp : LocationsApp?

    enum CodingKeys: String, CodingKey {

        case locationsApp = "LocationsApp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        locationsApp = try values.decodeIfPresent(LocationsApp.self, forKey: .locationsApp)
    }

}



