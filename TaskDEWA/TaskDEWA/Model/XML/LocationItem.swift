//
//  LocationService.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/10/22.
//

import Foundation
import CoreLocation
import MapKit


struct LocationItem: Codable {
    let id : String?
    let code : String?
    let latitude : String?
    let longitude : String?
    let title : String?
    let address : String?
    let addressdetails : String?
    let addressline1 : String?
    let landmark : String?
    let city : String?
    let countrycode : String?
    let zipcode : String?
    let officenumber : String?
    let callcenternumber : String?
    let emergencynumber : String?
    let workinghours : String?
    let website : String?
    let email : String?
    let makaninumber : String?
    let contacttext : [String]?
    let businesscardtext : [String]?
    let businesscardlink : String?
    let image : String?
    let map : String?
    var distance : Double {
        return LocationManager.shared.calculateDistance(latitude: latitude, longitude: longitude)
    }
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case code = "code"
        case latitude = "latitude"
        case longitude = "longitude"
        case title = "title"
        case address = "address"
        case addressdetails = "addressdetails"
        case addressline1 = "addressline1"
        case landmark = "landmark"
        case city = "city"
        case countrycode = "countrycode"
        case zipcode = "zipcode"
        case officenumber = "officenumber"
        case callcenternumber = "callcenternumber"
        case emergencynumber = "emergencynumber"
        case workinghours = "workinghours"
        case website = "website"
        case email = "email"
        case makaninumber = "makaninumber"
        case contacttext = "contacttext"
        case businesscardtext = "businesscardtext"
        case businesscardlink = "businesscardlink"
        case image = "image"
        case map = "map"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addressdetails = try values.decodeIfPresent(String.self, forKey: .addressdetails)
        addressline1 = try values.decodeIfPresent(String.self, forKey: .addressline1)
        landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        countrycode = try values.decodeIfPresent(String.self, forKey: .countrycode)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        officenumber = try values.decodeIfPresent(String.self, forKey: .officenumber)
        callcenternumber = try values.decodeIfPresent(String.self, forKey: .callcenternumber)
        emergencynumber = try values.decodeIfPresent(String.self, forKey: .emergencynumber)
        workinghours = try values.decodeIfPresent(String.self, forKey: .workinghours)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        makaninumber = try values.decodeIfPresent(String.self, forKey: .makaninumber)
        contacttext = try values.decodeIfPresent([String].self, forKey: .contacttext)
        businesscardtext = try values.decodeIfPresent([String].self, forKey: .businesscardtext)
        businesscardlink = try values.decodeIfPresent(String.self, forKey: .businesscardlink)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        map = try values.decodeIfPresent(String.self, forKey: .map)
    }
}

struct DistanceCalculator {
    var longitude : String?
    var latitude : String?
    var distance : Double {
        let latitude = Double(latitude ?? "")
        let longitude = Double(longitude ?? "")
        let destLoc   = CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        let calcDistance  = currentLocation.distance(from:destLoc )
        let km = String.init(format:"%.2f", calcDistance.getKms())
        return Double(km) ?? 0.0

    }
    var currentLocation : CLLocation{
        var currLoc = CLLocation()
        LocationManager.shared.getLocation { location, error in
            guard let location = location else {
                return
            }
            currLoc = location
        }
        return currLoc
    }
}
