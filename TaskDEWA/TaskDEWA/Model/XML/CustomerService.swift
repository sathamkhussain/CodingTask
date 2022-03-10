//
//  CustomerService.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/10/22.
//

import Foundation

struct CustomerService : Codable{
    var item  : [LocationItem?]
    enum codingKeys : String, CodingKey{
        case item
    }
}
