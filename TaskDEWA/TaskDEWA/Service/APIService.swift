//
//  WebService.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/8/22.
//

import Foundation
import XMLParsing
class APIService : NSObject, XMLParserDelegate{
    static let jsonURL = URL(string: "https://smartoffice.dewa.gov.ae/dev/DewaLocations.json")
    static let xmlURL = URL(string: "https://smartapps.dewa.gov.ae/iphone/Locations/Locations-En.xml")
    static func fetchDEWALocations() async throws -> Location? {
        guard let url = jsonURL else{
            throw APIError.invalidURL
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            do {
                let locations = try JSONDecoder().decode(Location.self, from: data)
                return locations
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }

        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }

    static func fetchCustomerServiceLocations() async throws -> Locations?{
        guard let url = xmlURL else{
            throw APIError.invalidURL
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                throw APIError.invalidResponseStatus
            }
            do{
                let decoder = XMLDecoder()
                let locations : Locations?
                locations = try decoder.decode(Locations.self, from: data)
                return locations
            }catch{
                throw APIError.decodingError(error.localizedDescription)
            }

        }catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)

    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return NSLocalizedString("The endpoint URL is invalid", comment: "")
            case .invalidResponseStatus:
                return NSLocalizedString("The API failed to issue a valid response.", comment: "")
            case .dataTaskError(let string):
                return string
            case .corruptData:
                return NSLocalizedString("The data provided appears to be corrupt", comment: "")
            case .decodingError(let string):
                return string
        }
    }
}
