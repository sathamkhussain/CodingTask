//
//  LocationViewController.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/9/22.
//

import UIKit
import CoreLocation

class DewaLocationsController: UIViewController, XMLParserDelegate {
    let locationVM = LocationViewModel()
    var location   : Location?

    @IBOutlet weak var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationCell")
        self.navigationItem.title  = "DEWA Locations"

    }

    override func viewDidAppear(_ animated: Bool) {
        Task.init{
            await locationVM.fetchLocationsFromJSONURL()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension DewaLocationsController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationVM.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationTableViewCell
        let data = locationVM.locations[indexPath.row]
        cell.configureCell(item: data!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = locationVM.locations[indexPath.row]
        let location = locationVM.getCoordinates(latitude: data?.lat, longitude: data?.lon)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetail") as! LocationDetailController
        controller.location = location
        controller.item = data
        self.navigationController?.pushViewController(controller, animated: true)

    }
}
