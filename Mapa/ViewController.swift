//
//  ViewController.swift
//  Mapa
//
//  Created by Henrique Souza on 25/07/16.
//  Copyright © 2016 Henrique Souza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let latitude:CLLocationDegrees = -23.545384
        let longitude:CLLocationDegrees = -46.724274
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta) //Create Zoom
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude) //Create Location
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span) //Set Location and Zoom
        
        map.setRegion(region, animated: true) //Set in Map Commponent
        
        var annotation = MKPointAnnotation() //Create annotation
        
        annotation.coordinate = location
        annotation.title = "Uma cidade"
        annotation.subtitle = "Uma cidade divertida"
        
        map.addAnnotation(annotation) //Set Annotation
    
        
        //Gesture Manager
        let pressedGesture = UILongPressGestureRecognizer(target: self, action: "action:")
        
        pressedGesture.minimumPressDuration = 2
        
        map.addGestureRecognizer(pressedGesture)
    }
    
    func action(_ gestureRecognizer: UILongPressGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        let newCoordinate: CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "Voce gosta deste lugar?"
        annotation.subtitle = "Realmente é um ótimo lugar"
        
        map.addAnnotation(annotation)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] //Return very much infomation in that Array, first is the actual location
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta) //Create Zoom
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude) //Create Location
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span) //Set Location and Zoom
        
        map.setRegion(region, animated: true) //Set in Map Commponent
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

