//
//  ContentView.swift
//  audiogame
//
//  Created by Robin Beer on 19.06.21.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    
    let game: Game
    @ObservedObject var locationViewModel: LocationViewModel
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    init() {
        game = Game(long: 0, lat: 0)
        locationViewModel = LocationViewModel()
        locationViewModel.setGame(game: game)
    }
    
    var body: some View {
//        VStack {
//
//            Text("Latitude: \(locationViewModel.userLatitude)")
//            Text("Longitude: \(locationViewModel.userLongitude)")
//        }
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow)).edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
