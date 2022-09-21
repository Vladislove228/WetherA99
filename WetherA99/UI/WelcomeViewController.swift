//
//  WelcomeViewController.swift
//  WetherA99
//
//  Created by Владислав Квинто on 17/09/2022.
//

import UIKit
import CoreLocation

import Reachability

class WelcomeViewController: UIViewController {
    let reachability = try! Reachability()
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Hello")
        currentLocation()
        locationManager.delegate = self
        timer1()
        reachabilityConnection()
        
        
    }
    func reachabilityConnection(){
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.showAllert()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    func showAllert(){
        let alert = UIAlertController(title: "no Interner", message: "This App Requires wifi/internet connection!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: {_ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func timer1 (){
        Timer.scheduledTimer(withTimeInterval: 0.000001, repeats: false){ [self]  timer in
            let vc = storyboard?.instantiateViewController(identifier: "ViewController") as!
            ViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
    }
    func currentLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100

        
    }
}
extension WelcomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else{
            return
        }
        Settings.locationLat = locationValue.latitude
        Settings.locationLon = locationValue.longitude
        print (Settings.locationLon)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        if status == .authorizedAlways ||
            status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        
    }
}
