//
//  LocationTableViewCell.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/9/22.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var officeNameLbl : UILabel!
    @IBOutlet weak var distanceLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(item : Item)  {
        officeNameLbl.text = item.office ?? ""
        distanceLbl.text = "\(item.distance ) KM Away from you"
    }

    func configureCSCell(locationItem : LocationItem){
        officeNameLbl.text = "\(locationItem.title ?? "") \n" + "\(locationItem.address! )"
        distanceLbl.text = "\(locationItem.distance ) KM Away from you"
    }

}
