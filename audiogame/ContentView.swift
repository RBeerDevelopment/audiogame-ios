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
    
    @State var game: Game
    @ObservedObject var locationViewModel: LocationViewModel
    
    private let objects: [SoundObject] = [
        SoundObject(lat: 48.78177957443577, long: 9.12039682240935, name: "thunder", soundExtension: "mp3", radius: 6.0),
        SoundObject(lat: 48.7813037988527, long: 9.117755210187507, name: "door", soundExtension: "mp3", radius: 7.0),
        SoundObject(lat: 48.781392765368196, long: 9.11853595342797, name: "water", soundExtension: "mp3", radius: 5.0),
        ]
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    init() {
        game = Game(self.objects)
        locationViewModel = LocationViewModel()
        locationViewModel.setGame(game: game)
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: objects) { object in
            MapMarker(coordinate: object.position)
            
        }
            .edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
