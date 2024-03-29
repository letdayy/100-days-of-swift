//
//  ViewController.swift
//  Project16
//
//  Created by leticia.dayane on 18/03/24.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    //challenge 2
    @IBOutlet weak var mapTypeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //challenge 3
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        let brasilia = Capital(title: "Brasilia", coordinate: CLLocationCoordinate2D(latitude: -15.7801, longitude: -47.9292), info: "https://en.wikipedia.org/wiki/Brasília")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington, brasilia])
        
        //challenge 2
        mapTypeButton?.layer.cornerRadius = 10
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        //challenge 1
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        //challenge 1
        annotationView?.markerTintColor = UIColor.purple
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }

        let placeInfo = capital.info
        
        //challenge 3
        let ac = UIAlertController(title: "Go to Wikipedia", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            let webViewController = WebViewController()
            webViewController.urlString = placeInfo
            self.navigationController?.pushViewController(webViewController, animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    //challenge 2
    @IBAction func mapTypeButtonTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Choose a map type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: {_ in
            self.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: {_ in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: {_ in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

