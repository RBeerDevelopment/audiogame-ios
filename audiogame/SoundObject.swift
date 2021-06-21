//
//  soundobject.swift
//  audiogame
//
//  Created by Robin Beer on 20.06.21.
//

import Foundation
import AVFoundation
import CoreLocation


class SoundObject: Identifiable {
    
    var id: UUID
    
    var position: CLLocationCoordinate2D, name: String, soundExtension: String, radius: Double
    
    var audioPlayer: AVAudioPlayer?
    
    init(lat: Double, long: Double, name: String, soundExtension: String, radius: Double = 1.0) {
        
        self.id = UUID()
        
        self.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
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
    
    private func isClose(_ distance: Double) -> Bool {
        return distance <= self.radius
    }
    
    public func onPlayerMoved(_ playerPostion: CLLocationCoordinate2D) {
        let distance = playerPostion.distance(from: self.position)
        if(isClose(distance)) {
            updateSound(distance)
        } else if self.isAudioPlaying() {
            audioPlayer?.stop()
        }
    }
    
    private func updateSound(_ distance: Double) {
        let volume = calculateVolume(distance)
        print("Playing \(self.name) at volume: \(volume)")
        audioPlayer?.setVolume(volume, fadeDuration: 0.2)
        if (!self.isAudioPlaying()) {
            audioPlayer?.play()
        }
    }
    
    func calculateVolume(_ distance: Double) -> Float {
        return Float(1.0 - distance/self.radius)
    }
    
    private func isAudioPlaying() -> Bool {
        if audioPlayer != nil {
            return audioPlayer!.isPlaying
        } else {
            return false
        }
    }
    
    private func setupAudioPlayer() {
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
    
}
