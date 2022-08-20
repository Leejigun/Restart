//
//  AudioPlayer.swift
//  Restart
//
//  Created by bimo.ez on 2022/08/20.
//

import Foundation
import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    private var player: AVAudioPlayer?
    
    enum Audios: String {
        case chimeup
        case success
        
        var format: String {
            switch self {
            case .chimeup: return "mp3"
            case .success: return "m4a"
            }
        }
    }
    
    func playSound(sound: AudioPlayer.Audios) {
        if let path = Bundle.main.path(forResource: sound.rawValue, ofType: sound.format) {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player?.play()
            } catch {
                print("Could not play the sound file.")
            }
        } else {
            print("Could find path")
        }
    }
}
