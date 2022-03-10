//
//  CSLocationController.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/10/22.
//

import UIKit

class CSLocationController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    let locationVM = LocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationCell")
        self.navigationItem.title  = "CS Locations"
    }
    override func viewDidAppear(_ animated: Bool) {
        Task.init{
            await locationVM.fetchCSLocationFromXML()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension CSLocationController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationVM.csLocationItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationTableViewCell
        let data = locationVM.csLocationItems[indexPath.row]
        cell.configureCSCell(locationItem: data!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = locationVM.csLocationItems[indexPath.row]
        let location = locationVM.getCoordinates(latitude: data?.latitude, longitude: data?.longitude)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetail") as! LocationDetailController
        controller.location = location
        controller.infoType = .CSLOCATION
        controller.locationItem = data
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
