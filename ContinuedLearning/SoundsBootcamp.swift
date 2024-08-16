//
//  SoundsBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 16.08.24.
//

import SwiftUI
import AVKit // AudioVideoKit

class SoundManager{
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String{
        case tada = "Tada-sound"
        case badum = "Badum-tss"
    }
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch{
            print("Error playing sound \(error.localizedDescription)")
        }
        
    }
}

struct SoundsBootcamp: View {
    
    var body: some View {
        VStack(spacing: 40){
            Button("Play sound 1"){
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play sound 2"){
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
