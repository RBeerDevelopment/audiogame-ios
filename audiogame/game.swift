//
//  game.swift
//  audiogame
//
//  Created by Robin Beer on 19.06.21.
//

import Foundation
import AVFoundation

class Game {
    
    var long: Double, lat: Double
    var objects: [SoundObject]
    
    var stepPlayer: AVAudioPlayer?
    
    init(long: Double, lat: Double) {
        self.long = long
        self.lat = lat
        print("\(self.lat), \(self.long)")
        self.objects = [
            SoundObject(lat: 48.208148, long: 16.382691, name: "thunder", soundExtension: "mp3", radius: 3.0),
//            SoundObject(x: 7, y: 2, name: "water", soundExtension: "mp3", radius: 7.0),
//            SoundObject(x: 1, y: 1, name: "door", soundExtension: "mp3", radius: 2.0),
        ]
//        self.setupStepPlayer()
    }
    
    func moved() {
        print("moved")
        printCurrentPosition()
        for object in objects {
            object.onPlayerMoved(playerLat: self.lat, playerLong: self.long)
        }
        self.stepPlayer?.stop()
        self.stepPlayer?.play()
    }
    
    func updateLocation(lat: Double, long: Double) {
        print("updateLocation")
        print("isSignificant: \(self.isChangeSignificant(lat: lat, long: long))")
        if (self.isChangeSignificant(lat: lat, long: long)) {
            self.lat = lat
            self.long = long
            self.moved()
        }
    }
    
    func coordinateDistanceInMeters(difference: Double) -> Double {
        return difference*100_000/1.11
    }
    
    func isChangeSignificant(lat: Double, long: Double) -> Bool {
        print("LatDiff: \(coordinateDistanceInMeters(difference: self.lat - lat))")
        print("LongDiff: \(coordinateDistanceInMeters(difference: self.long - long))")
        let isLatSignificant = abs(coordinateDistanceInMeters(difference: self.lat - lat)) > 0.05
        let isLongSignificant = abs(coordinateDistanceInMeters(difference: self.long - long)) > 0.05
        print("isChangeSignificant: \((isLatSignificant))")
        return (isLatSignificant || isLongSignificant)
    }
    
    
    func printCurrentPosition() {
        print("Position: \(self.lat) \(self.long)")
    }
    
//    func setupStepPlayer() {
//        if let path = Bundle.main.path(forResource: "sounds/step", ofType: "mp3") {
//                do {
//                    stepPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//                    stepPlayer?.numberOfLoops = 1
//                    stepPlayer?.prepareToPlay()
//                } catch {
//                    print("ERROR")
//                }
//
//        }
//    }

}
