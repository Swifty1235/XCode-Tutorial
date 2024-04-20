//
//  ContentView.swift
//  XCode Tutorial
//
//  Created by Pedro Romero on 4/3/24.
//

import SwiftUI
import AVFoundation



struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    @State public var playingMusic = false
    
    var body: some View {
        VStack {
            Image(.cactus)
                .resizable()
                .cornerRadius(20)
            //.scaleEffect(0.5)
                .frame(width: 200 ,  height: 250)
            
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                Text("Hello, on if cool. Off if not")
                
            }
            
            
            Text("Hello my peep!")
                .foregroundStyle(.specialcolor)
                .italic()
                .underline()
                .padding(.top, 40)
            
            DatePicker(selection: .constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Choose Date") })
            Button("click for persona 4 music") {
                playSound(sound: "persona4" , type: "mp3")
                playingMusic = true
                }
                
            }
        //Text that Displays
        if playingMusic{
            Text("playing")
            
        }
        
    }
    
    //Function for Music
    func playSound(sound: String, type: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: type) else {
            print("Error: sound file not found.")
            return
        }
        do {
            // Initialize the state property with the new AVAudioPlayer instance
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    ContentView()
}


