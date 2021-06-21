//
//  soundobject.swift
//  audiogame
//
//  Created by Robin Beer on 20.06.21.
//

import Foundation
import AVFoundation



func calculateDistanceInMeters(playerLat: Double, playerLong: Double, objectLat: Double, objectLong: Double) -> Double {
    let longDistance = playerLong - objectLong
    let latDistance = playerLat - objectLat
    return Double(longDistance*longDistance + latDistance*latDistance).squareRoot()*100_0000
}

class SoundObject {
    
    var lat: Double, long: Double, name: String, soundExtension: String, radius: Double
    
    var audioPlayer: AVAudioPlayer?
    
    init(lat: Double, long: Double, name: String, soundExtension: String, radius: Double = 1.0) {
        self.lat = lat
        self.long = long
        self.name = name
        self.soundExtension = soundExtension
        self.radius = radius
    
        self.setupAudioPlayer()
    }
    
    deinit {
        if audioPlayer !== nil {
            audioPlayer = nil
        }
    }
    
    func isClose(_ distance: Double) -> Bool {
        return distance <= self.radius
    }
    
    func setupAudioPlayer() {
        if let path = Bundle.main.path(forResource: "sounds/" + self.name, ofType: self.soundExtension) {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.numberOfLoops = -1
                    audioPlayer?.prepareToPlay()
                } catch {
                    print("ERROR")
                }
        
        }
    }
    
    
    func onPlayerMoved(playerLat: Double, playerLong: Double) {
        let distance = calculateDistanceInMeters(playerLat: playerLat, playerLong: playerLong, objectLat: lat, objectLong: long)
        print("newDistanceToObject: \(distance)")
        if(isClose(distance)) {
            updateSound(distance)
        } else if self.isAudioPlaying() {
            audioPlayer?.stop()
        }
    }
    
    func updateSound(_ distance: Double) {
        print("\(self.name): \(Float(1.0 - distance/self.radius))")
        audioPlayer?.setVolume(Float(1.0 - distance/self.radius), fadeDuration: 0.2)
        if (!self.isAudioPlaying()) {
            print("play called")
            audioPlayer?.play()
        }
    }
    
    func isAudioPlaying() -> Bool {
        if audioPlayer != nil {
            return audioPlayer!.isPlaying
        } else {
            return false
        }
    }
    
}
