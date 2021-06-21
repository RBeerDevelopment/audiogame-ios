//
//  game.swift
//  audiogame
//
//  Created by Robin Beer on 19.06.21.
//

import Foundation
import AVFoundation
import MapKit

class Game {
    
    let SIGNFICANT_DISTANCE = 0.1
    
    var position: CLLocationCoordinate2D
    var objects: [SoundObject]
    
    init(_ objects: [SoundObject]) {
        position = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        self.objects = objects
    }
    
    func onLocationChanged(lat: Double, long: Double) {
        let newPosition = CLLocationCoordinate2D(latitude: lat, longitude: long)
        if (newPosition.distance(from: self.position) > self.SIGNFICANT_DISTANCE) {
            self.position = newPosition
            printCurrentPosition()
            for object in objects {
                object.onPlayerMoved(self.position)
            }
        }
    }
    
    func printCurrentPosition() {
        print("Position: \(self.position.latitude), \(self.position.longitude)")
    }

}
