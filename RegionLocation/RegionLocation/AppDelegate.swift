//
//  AppDelegate.swift
//  RegionLocation
//
//  Created by Joe on 04/12/22.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {


    var locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    
                    if CLLocationManager.locationServicesEnabled()
                    {
                        switch(CLLocationManager.authorizationStatus())
                        {
                        case .authorizedAlways, .authorizedWhenInUse:
                            locationManager.startUpdatingLocation()
                            break
                        case .notDetermined:
                            locationManager.requestWhenInUseAuthorization()
                            break
                        case .restricted:
                            print("Restricted.")
                            break
                        case .denied:
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        @unknown default:
                            locationManager.requestWhenInUseAuthorization()
                            break
                        }
                    }
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
        {
            if status == .authorizedWhenInUse
            {
                locationManager.startUpdatingLocation()
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
//            print("User current location===>>",locations)
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

