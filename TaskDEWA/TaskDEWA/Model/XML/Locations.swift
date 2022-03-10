//
//  CustomerService.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/10/22.
//

import Foundation
struct Locations : Codable{
    var CustomerService : CustomerService?
    enum codingKeys : String, CodingKey{
        case CustomerService = "CustomerService"
    }
}
