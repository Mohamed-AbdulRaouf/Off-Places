//
//  MapView.swift
//  Off-Places
//
//  Created by Esraa on 4/26/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import Mapbox

class MapView: UIViewController, MGLMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mapStyle: CustomView!

    private var locationManager: CLLocationManager!
    let mapView = MGLMapView()

    let CAIRO_LATITUDE = 30.0444
    let CAIRO_LONGITUDE = 31.2357
    var currentLocation = Location(name: "Cairo", coordinates: Coordinates(latitude: 30.0444, longitude: 31.2357))

    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .denied, .notDetermined, .restricted:
            initMapView( CAIRO_LATITUDE, CAIRO_LONGITUDE)
        case .authorizedAlways, .authorizedWhenInUse:
            initMapView( locationManager.location?.coordinate.latitude ?? CAIRO_LATITUDE ,
                         locationManager.location?.coordinate.longitude ?? CAIRO_LONGITUDE)
        }
    }
    
    func initMapView(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        
        self.currentLocation.coordinates = Coordinates(latitude: latitude, longitude: longitude)
        LocationHelper.getLocationName(CLLocation(latitude: currentLocation.coordinates.latitude,
                                                  longitude: currentLocation.coordinates.longitude))
        { self.currentLocation.name = $0}
        
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoomLevel: 12, animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
        
        let marker = MGLPointAnnotation()
        marker.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(marker)

        view.insertSubview(mapStyle, aboveSubview: mapView)
        view.insertSubview(saveButton, aboveSubview: mapView)
    }
    
    @IBAction func changeMapStyle(_ sender: CustomView) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.styleURL = MGLStyle.satelliteStyleURL
        case 1:
            mapView.styleURL = MGLStyle.streetsStyleURL
        case 2:
            mapView.styleURL = MGLStyle.lightStyleURL
        default:
            mapView.styleURL = MGLStyle.streetsStyleURL
        }
    }

    @IBAction func saveLocationIsPressed(_ sender: UIButton) {
        StorageControler.save(location: currentLocation)
    }
}
