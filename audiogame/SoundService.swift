//
//  SoundService.swift
//  audiogame
//
//  Created by Robin Beer on 22.06.21.
//

import Foundation
import AVFoundation

// Not yet used

class SoundService {
    private var players: [String:AVAudioPlayer]
    
    init() {
        players = [:]
    }
    
    func playAtVolume(_ soundName: String, volume: Float) {
        // check if player is already setup
        if(doesPlayerExist(soundName)) {
            players[soundName]?.setVolume(volume, fadeDuration: 0.2)
            if (!isSoundPlaying(soundName)) {
                players[soundName]?.play()
            }
        } else {
            let newPlayer = setupNewPlayer(soundName)
            players[soundName] = newPlayer
            playAtVolume(soundName, volume: volume)
        }
    }
    
    private func doesPlayerExist(_ soundName: String) -> Bool {
        return players.keys.contains(soundName)
    }
    
    private func isSoundPlaying(_ soundName: String) -> Bool {
        if doesPlayerExist(soundName) {
            return players[soundName]!.isPlaying
        } else {
            return false
        }
    }
    
    private func setupNewPlayer(_ soundName: String) -> AVAudioPlayer? {
        var audioPlayer: AVAudioPlayer
        if let path = Bundle.main.path(forResource: "sounds/" + soundName, ofType: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer.numberOfLoops = -1
                    audioPlayer.prepareToPlay()
                    return audioPlayer
                    
                } catch {
                    print("ERROR")
                    
                }
        }
        return nil
    }
}
