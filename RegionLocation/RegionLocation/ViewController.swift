//
//  ViewController.swift
//  RegionLocation
//
//  Created by Joe on 04/12/22.
//

import UIKit
import CoreLocation
import MapKit



class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var regionManager : CLRegion!
    var circularRegion : CLCircularRegion!
    var done_myInit = false;

    var latArr = [12.953013054035946,12.95428866232216,12.95558517552543,12.956442543452548,12.95675621390793,12.957069883968225,12.957711349517467,12.958464154110917,12.959656090062529,12.960814324441305,12.961253455257907,12.96156308861349,12.961814019848779,12.962775920574138,12.963340512746937,12.96411114676894,12.964382986146292,12.964584624077109,12.964542802687657,12.963795326167373,12.96358621848664,12.963481664580394]
    var longArr = [77.5417514266668,77.5438757362066,77.54565672299249,77.54752354046686,77.54919723889215,77.55112842938287,77.55308710458465,77.55514704110809,77.5559409749765,77.5574167738546,77.5592192183126,77.56126500049922,77.56308890262935,77.56592131534907,77.5676379291186,77.56951526792183,77.5717254081501,77.57370388966811,77.57591402989638,77.57798997552734,77.58015720041138,77.58189527185303]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()

        regionManager = CLRegion()
        circularRegion = CLCircularRegion()

        var i = 0
        while i < latArr.count {
            let cordinates = CLLocationCoordinate2DMake(latArr[i], longArr[i])
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 1.0)
            let region = MKCoordinateRegion(center: cordinates, span: span)
            mapView.setRegion(region, animated: true)
            
            circularRegion = CLCircularRegion.init(
                center: cordinates,
                radius: 100,
                identifier: "Region \(i)"
            )
            
            locationManager.startMonitoring(for: CLCircularRegion(
                center: CLLocationCoordinate2D(latitude:latArr[i], longitude:longArr[i]),
                radius: CLLocationDistance(100),
                identifier: "Somewhere1"))
            
            let pin = MKPointAnnotation()
            pin.coordinate = cordinates
            mapView.addAnnotation(pin)
            i = i + 1
        }
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dts = dateFormatter.string(from: Date())
        print("Enter " + region.identifier + " @" + dts)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dts = dateFormatter.string(from: Date())
        print("Leave " + region.identifier + " @" + dts)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        // create a corresponding local notification
        print("Error " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            var i = 0
            while i < latArr.count {
                locationManager.startMonitoring(for: CLCircularRegion(
                    center: CLLocationCoordinate2D(latitude:latArr[i], longitude:longArr[i]),
                    radius: CLLocationDistance(100),
                    identifier: "Somewhere\(i)"))
                i = i + 1
            }
        }
    }

}

