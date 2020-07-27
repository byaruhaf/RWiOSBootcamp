//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import AVFoundation

class SoundManager: NSObject {

    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    //Saved Sound setting's
    var isSoundEnabled: Bool {
        get {
            if UserDefaults.standard.object(forKey: K.Keys.soundKey) == nil {
                toggleSoundPreference()
            }
            return UserDefaults.standard.bool(forKey: K.Keys.soundKey)
        }
    }


    // Stop playing the sound.
    public func stopSound() {
        guard let player = player else { return }
        player.stop()
    }


    // Start Plyaing Sound
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
        let current = UserDefaults.standard.bool(forKey: K.Keys.soundKey)
        UserDefaults.standard.set(!current, forKey: K.Keys.soundKey)
    }


}
