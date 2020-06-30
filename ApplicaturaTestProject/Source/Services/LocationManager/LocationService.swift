import CoreLocation

final class LocationService: NSObject {
    static let shared = LocationService()
    
    private let locationManager = CLLocationManager()
    
    @discardableResult
    override init() {
        super.init()
        checkLocationService()
    }
    
    func getUserLocation() -> (lat: Double, lon: Double) {
        if let location = locationManager.location?.coordinate {
            return (location.latitude, location.longitude)
        }
        return (0, 0)
    }
    
    func setupLocationService() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
        case .denied: break
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .restricted: break
        case .authorizedAlways: break
        @unknown default: break
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorisation()
    }
}

