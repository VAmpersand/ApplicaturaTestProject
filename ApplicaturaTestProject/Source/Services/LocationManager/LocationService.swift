import CoreLocation

final class LocationService: NSObject {
    static let shared = LocationService()
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        checkLocationService()
    }
    
    func getUserLocation() -> (lat: Double, lon: Double)? {
        if let location = locationManager.location?.coordinate {
            return (location.latitude, location.longitude)
        }
        return nil
    }
    
    func setupLocationService() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationService()
            checkLocationAuthorisation()
        }
    }
    
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: locationManager.stopUpdatingLocation()
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        default: break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorisation()
        NotificationCenter.default.post(name: .locationServiceWasSetup, object: nil)
    }
}

