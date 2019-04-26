//
//  SavedLocationsView.swift
//  Off-Places
//
//  Created by Esraa on 4/26/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class SavedLocationsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentPlace: String!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userLocationCell", for: indexPath) as? UserLocationCell {
            cell.configer(currentPlace)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
