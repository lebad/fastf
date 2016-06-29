//
//  MapViewController.swift
//  foodSearcher
//
//  Created by andrey on 16/06/16.
//  Copyright © 2016 AndreyLebedev. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

protocol MapViewControllerOutput {
  func requestAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
  
  func fetchPins()
}

protocol MapViewControllerInput {
  func displayCurrentLocation(responce: Map.Response)
  func displayPins(response: Map.Response)
}

class MapViewController: UIViewController, MapViewControllerInput {
  
  var output: MapViewControllerOutput!
  var router: MapRouter!
  
  @IBOutlet weak var mapView: GMSMapView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    MapConfigurator.configure(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    output.requestAuthorization()
    output.startUpdatingLocation()
  }
  
  func didSuccessAuthorization() {
    mapView.myLocationEnabled = true
    mapView.settings.myLocationButton = true
  }
  
  func didUpdateLocation(response: Map.Response.UserLocation) {
    let coordinate = CLLocationCoordinate2D(latitude: response.latitude, longitude: response.longitude)
    mapView.camera = GMSCameraPosition(target: coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    output.stopUpdatingLocation()
    
    output.fetchPins()
  }
  
  func showPins(response: Map.Response) {
    for pin in response.pins {
      let position = CLLocationCoordinate2D(latitude: pin.latitude!, longitude: pin.longitude!)
      let marker = GMSMarker(position: position)
      marker.map = mapView
    }
  }
  
  
  
  func displayCurrentLocation(responce: Map.Response) {
    
  }
  
  func displayPins(response: Map.Response) {
    
  }

}

extension MapViewController: FromViewController {
  
}
