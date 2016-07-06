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
  var pins: [Pin]? { get set }
}

protocol MapViewControllerInput {
  
}

class MapViewController: UIViewController, MapViewControllerInput {
  
  var output: MapViewControllerOutput!
  var router: MapRouter!
  
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var bottomInformationView: MapBottomInformationView! {
    didSet {
      bottomInformationView.alpha = 0.0
    }
  }
  @IBOutlet weak var containerView: UIView!
  var tabBar: UITabBar! = UITabBar(frame: CGRectZero)
  
  var markers = [GMSMarker]()
  var selectedIndex: Int?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    MapConfigurator.configure(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    output.requestAuthorization()
    output.startUpdatingLocation()
    
    router.instantiateAnimator()
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
      self.markers.append(marker)
    }
  }
  
  func showBottomInformationViewForPin(pin: Pin) {
    self.bottomInformationView.nameLabel.text = pin.name
    self.bottomInformationView.addressLabel.text = pin.address
    
    UIView.animateWithDuration(0.3) { 
      self.bottomInformationView.alpha = 1.0
    }
  }
  
  func hideBottomInformationView() {
    UIView.animateWithDuration(0.3) {
      self.bottomInformationView.alpha = 0.0
    }
  }
  
  // MARK: - Actions
  
  @IBAction func informationButtonAction(sender: UIButton) {
    self.router.navigateToDescription()
  }

}

extension MapViewController: FromViewController {

  func getTargetView() -> UIView {
    return self.bottomInformationView
  }
  
  func pushViewController(viewController: UIViewController) {
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  func presentViewController(viewController: UIViewController) {
    self.presentViewController(viewController, animated: true, completion: nil)
  }
  
  func beginAppearanceTransition() {
    self.beginAppearanceTransition(false, animated: false)
  }

  func endAppearanceTransitionFromVC() {
    self.endAppearanceTransition()
  }
}
