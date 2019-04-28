//
//  SavedLocationsView.swift
//  Off-Places
//
//  Created by Esraa on 4/26/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class SavedLocationsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var currentPlace: String?
    var savedPlacesList = ["a", "b", "c", "D", "E"]

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if let currentPlace = currentPlace {
            savedPlacesList.append(currentPlace)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPlacesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userLocationCell", for: indexPath) as? UserLocationCell {
            cell.configer(savedPlacesList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ToMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMap" {
            if let vc = segue.destination as? MapView {
                vc.currentLocation.name = currentPlace ?? "5"
            }
        }
    }
    
    @IBAction func openMapIsPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}


