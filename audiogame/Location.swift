//
//  location.swift
//  audiogame
//
//  Created by Robin Beer on 21.06.21.
//

import CoreLocation


class LocationViewModel: NSObject, ObservableObject {
  
  @Published var userLatitude: Double = 0
  @Published var userLongitude: Double = 0
  
  private let locationManager = CLLocationManager()
    private var game: Game? = nil
  
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
  }
    
    func setGame(game: Game) {
        self.game = game
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    userLatitude = location.coordinate.latitude
    userLongitude = location.coordinate.longitude
    self.game?.onLocationChanged(lat: userLatitude, long: userLongitude)
  }
}

