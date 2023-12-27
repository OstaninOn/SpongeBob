//
//  MusicSound.swift
//  GestureCat
//
//  Created by  aleksandr on 24.11.22.
//

import UIKit
import AVFoundation

class MusicSound {
    
    static let shared = MusicSound()
    var audioPlayer: AVAudioPlayer?
    var isOn = StoreManager.shared.isSoundsOn
    
    private init() { }
    
    func playMusicSound() {
        guard isOn else { return }
        
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "hrums", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = 0
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            } catch {
        }
    }
}
