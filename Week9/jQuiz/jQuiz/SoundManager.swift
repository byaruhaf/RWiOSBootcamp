//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    // Globally enable or disable sound. This setting value is stored in UserDefaults and will be loaded on app launch.
    var isSoundEnabled: Bool = { return !UserDefaults.standard.bool(forKey: K.Keys.soundKey)}(){
        didSet {
            let value = !isSoundEnabled
            UserDefaults.standard.set(value, forKey: K.Keys.soundKey)
            if value {
                stopSound()
            }
        }
    }

    // Stop playing the sound.
    public func stopSound() {
        guard let player = player else { return }
            player.stop()
    }


//    var isSoundEnabled: Bool? {
//        get {
//            // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
//            // You might want to use `object`, because if an object has not been set yet it will be nil
//            // Then if it's nil you know it's the user's first time launching the app
//            UserDefaults.standard.object(forKey: Keys.soundKey) as? Bool
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.soundKey)
//        }
//    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "bensound-ukulele", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
           guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func toggleSoundPreference() {
//        if let isSoundEnabled = isSoundEnabled{
            if isSoundEnabled {
                self.isSoundEnabled = false
                player?.stop()
            }else {
                self.isSoundEnabled = true
                playSound()
            }

//        }
    }

}
