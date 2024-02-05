//
//  MusicHelperGame.swift
//  GestureCat
//
//  Created by  aleksandr on 1.02.24.
//

//import UIKit
//import AVFoundation
//
//class MusicHelperGame {
//    
//    
//    static let sharedGame = MusicHelperGame()
//
//    
//    var audioPlayerGame: AVAudioPlayer = {
//        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "musicGame", ofType: "mp3")!)
//        do {
//            return try AVAudioPlayer(contentsOf:aSound as URL)
//        } catch {
//            return AVAudioPlayer()
//        }
//    }()
//    
//    
//    var isOn = StoreManager.shared.isMusicOn {
//        didSet {
//            if isOn {
//                playBackgroundMusic()
//            } else {
//                stopBackgroundMusic()
//            }
//        }
//    }
//    
//    var isOnGame = StoreManager.shared.isMusicOn {
//        didSet {
//            if isOn {
//                playBackgroundMusicGame()
//            } else {
//                stopBackgroundMusicGame()
//            }
//        }
//    }
//    
//    private init() { }
//    
//    func playBackgroundMusic() {
//        guard isOn else { return }
//        audioPlayerGame.numberOfLoops = 1
//        audioPlayerGame.prepareToPlay()
//        audioPlayerGame.play()
//    }
//    
//    func playBackgroundMusicGame() {
//        guard isOn else { return }
//        audioPlayerGame.numberOfLoops = 1
//        audioPlayerGame.prepareToPlay()
//        audioPlayerGame.play()
//    }
//    
//    func stopBackgroundMusic() {
//        audioPlayerGame.stop()
//    }
//    
//    func stopBackgroundMusicGame() {
//        audioPlayerGame.stop()
//    }
//    
//}
