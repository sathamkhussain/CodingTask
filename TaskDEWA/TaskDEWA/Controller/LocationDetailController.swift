//
//  LocationDetailController.swift
//  TaskDEWA
//
//  Created by Satham Hussain on 3/9/22.
//

import UIKit
import MapKit

class LocationDetailController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailTxtView : UITextView!
    private let reuseIdentifier = "MyIdentifier"

    enum InfoType {
        case  DEWALOCATION
        case  CSLOCATION
    }

    var item : Item?
    var locationItem : LocationItem?
    var location : CLLocation?
    var locationTitle : String?
    var infoType : InfoType? = .DEWALOCATION
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.addLocationInfo()
        self.addPin()

    }

    func addLocationInfo()  {
        switch infoType{
            case .DEWALOCATION:
                detailTxtView.text = "\(item?.office ?? "")\n  \(item?.loc ?? "")"
                self.locationTitle = item?.loc ?? ""
                break

            case .CSLOCATION:
                detailTxtView.text =  "\(locationItem?.title ?? "")\n -\(locationItem?.addressdetails ?? "")\n -\(locationItem?.workinghours ?? "")"
                self.locationTitle = locationItem?.title ?? ""
                break
            case .none:
                break
        }
    }

    func addPin() {
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = locationTitle
        self.mapView.addAnnotation(objectAnnotation)
    }
}

extension LocationDetailController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: LocationManager.shared.lastLocation?.coordinate.latitude ?? 0.0, longitude: LocationManager.shared.lastLocation?.coordinate.longitude ?? 0.0 )))
        source.name = "Source"

        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location?.coordinate.latitude ?? 0.0, longitude: location?.coordinate.longitude ?? 0.0)))
        destination.name = "Destination"
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        print("didSelectAnnotationTapped")
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.tintColor = .green                // do whatever customization you want
            annotationView?.canShowCallout = true            // but turn off callout

            let button = UIButton(type: .infoDark)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}

class AnnotationButton: UIButton {
    var annotation: MKPointAnnotation?
}

extension MKPointAnnotation {
    var mapItem: MKMapItem {
        let placemark = MKPlacemark(coordinate: self.coordinate)
        return MKMapItem(placemark: placemark)
    }
}
