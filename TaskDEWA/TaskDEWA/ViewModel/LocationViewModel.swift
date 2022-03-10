//
//  LocationViewModel.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/8/22.
//

import Foundation
import CoreLocation
class LocationViewModel : ObservableObject  {
     @Published var locations : [Item?] = []
    @Published var csLocationItems : [LocationItem?] = []
    var currentLocatioin : CLLocation?
    init(){
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in
            if let error = error {
                print(error)
            }
            guard let location = location else {
                return
            }
            self.currentLocatioin = location
        }
    }

    func fetchLocationsFromJSONURL() async{
        do{
            let  locations = try await APIService.fetchDEWALocations()
            DispatchQueue.main.async {
                self.locations = locations?.locationsApp?.cordinate?.item ?? []
                self.locations.sort(by: { $0?.distance ?? 0.0 < $1?.distance ?? 0.0})

            }
        }catch{
            print("Something bad happened \(error)")
        }
    }

    func fetchCSLocationFromXML() async{
        do{
            let csLocations = try await APIService.fetchCustomerServiceLocations()
            DispatchQueue.main.async {
                self.csLocationItems = csLocations?.CustomerService?.item ?? []
                self.csLocationItems.sort(by: { $0?.distance ?? 0.0 < $1?.distance ?? 0.0})
            }
        }catch{
            print("Something bad happened \(error)")
        }
    }

    func getCoordinates(latitude : String?, longitude : String?) -> CLLocation{
        let lat =  Double(latitude ?? "") ?? 0.0
        let longt = Double(longitude ?? "") ?? 0.0
        let coordinate = CLLocation(latitude: lat, longitude: longt)
        return coordinate
    }
}


