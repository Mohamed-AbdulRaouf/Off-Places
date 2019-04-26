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
    var currentLocation: CLLocation!
    
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
        
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoomLevel: 12, animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
        
        let marker = MGLPointAnnotation()
        marker.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(marker)
        
        currentLocation = CLLocation(latitude: CAIRO_LATITUDE, longitude: CAIRO_LONGITUDE)
        
        view.insertSubview(mapStyle, aboveSubview: mapView)
        view.insertSubview(saveButton, aboveSubview: mapView)
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
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
    
    func getLocationName(_ location: CLLocation) -> String {
        var x = ""
        let locon = CLLocation(latitude: 40.730610, longitude:  -73.935242) // <- New York
        CLGeocoder().reverseGeocodeLocation(locon) { (placemarks, error) in
            placemarks?.forEach { (placemark) in
                
                if let city = placemark.locality { print(city) }
            }
        }
        return x
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSavedPlaces" {
            if let vc = segue.destination as? SavedLocationsView {
                let x = getLocationName(currentLocation)
                vc.currentPlace = "\(x)"
            }
        }
        
    }
}
