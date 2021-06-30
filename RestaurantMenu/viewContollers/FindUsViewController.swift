//
//  FindUsViewController.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 10.6.21.
//

import Foundation
import UIKit
import Combine
import CoreLocation
import UserNotifications
import Contacts

import MapKit

class FindUsViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    let restaurantLocation = CLLocationCoordinate2D(latitude: 41.992686, longitude: 21.420458)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        configureMapView()
    }
    
    // MARK: - private
    
    private func configureMapView() {
        mapView.addAnnotation(ResturantAnnotation(title: "Our Restaurant", coordinate: restaurantLocation))
        let region = MKCoordinateRegion(center: restaurantLocation,
                                        latitudinalMeters: 50000,
                                        longitudinalMeters: 60000)
        
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        if let initialLocation = locationManager?.location {
            mapView.centerToLocation(initialLocation)
        }
    }
}

extension FindUsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let resturantAnnotation = view.annotation as? ResturantAnnotation else {
            return
        }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        resturantAnnotation.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

class ResturantAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(title: String?,coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    var mapItem: MKMapItem? {
        let addressDict = [CNPostalAddressStreetKey: "Vasil Gjorgov 16, Skopje 1000"]
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
