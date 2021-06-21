//
//  ContentView.swift
//  audiogame
//
//  Created by Robin Beer on 19.06.21.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    let game: Game
    @ObservedObject var locationViewModel: LocationViewModel
    
    init() {
        game = Game(long: 0, lat: 0)
        locationViewModel = LocationViewModel()
        locationViewModel.setGame(game: game)
    }
    
    var body: some View {
        VStack {
//            Button("Up") {
//                game.moveUp()
//            }
//            Button("Down") {
//                game.moveDown()
//            }
//            Button("Left") {
//                game.moveLeft()
//            }
//            Button("Right") {
//                game.moveRight()
//            }
            
            Text("Latitude: \(locationViewModel.userLatitude)")
            Text("Longitude: \(locationViewModel.userLongitude)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
