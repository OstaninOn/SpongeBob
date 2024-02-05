//
//  MusicHelper.swift
//  GestureCat
//
//  Created by  aleksandr on 24.11.22.
//
import UIKit
import AVFoundation

class MusicHelper {
    
    static let shared = MusicHelper()
    static let sharedGame = MusicHelper()
    var audioPlayer: AVAudioPlayer = {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "MusikFon", ofType: "mp3")!)
        do {
            return try AVAudioPlayer(contentsOf:aSound as URL)
        } catch {
            return AVAudioPlayer()
        }
    }()
    
    var audioPlayerGame: AVAudioPlayer = {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "musicGame", ofType: "mp3")!)
        do {
            return try AVAudioPlayer(contentsOf:aSound as URL)
        } catch {
            return AVAudioPlayer()
        }
    }()
    
    
    var isOn = StoreManager.shared.isMusicOn {
        didSet {
            if isOn {
                playBackgroundMusic()
            } else {
                stopBackgroundMusic()
            }
        }
    }
    
    var isOnGame = StoreManager.sharedGame.isMusicOn {
        didSet {
            if isOnGame {
                playBackgroundMusicGame()
            } else {
                stopBackgroundMusicGame()
            }
        }
    }
    
    private init() { }
    
    func playBackgroundMusic() {
        guard isOn else { return }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func playBackgroundMusicGame() {
        guard isOnGame else { return }
        audioPlayerGame.numberOfLoops = -1
        audioPlayerGame.prepareToPlay()
        audioPlayerGame.play()
    }
    
    func stopBackgroundMusic() {
        audioPlayer.stop()
    }
    
    func stopBackgroundMusicGame() {
        audioPlayerGame.stop()
    }
    
}
