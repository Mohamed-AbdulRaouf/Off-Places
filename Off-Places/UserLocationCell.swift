//
//  UserLocationCell.swift
//  Off-Places
//
//  Created by Esraa on 4/26/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class UserLocationCell: UITableViewCell {
    
    @IBOutlet weak var LocationLabel: UILabel!
    
    func configer(_ location: String) {
        LocationLabel.text = location
    }
}
