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
    @State private var playingMusic = false
    
    //Strings for User/Pass
    @State private var username: String = ""
    @State private var password: String = ""

    
    var body: some View {
        VStack {
            Image(.cactus)
                .resizable()
                .cornerRadius(20)
            //.scaleEffect(0.5)
                .frame(width: 200 ,  height: 250)
            
            TextField("Username", text: $username)
                            .padding()
                            .border(Color.gray)
                        SecureField("Password", text: $password)
                            .padding()
                            .border(Color.gray)
            Button("Register") {
                registerUser(username: username, password: password)
            }
            
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

func registerUser(username: String, password: String) {
    guard let url = URL(string: "https://jdrxcrrpapnzdjdhmdnk.supabase.co") else {
        print("Invalid URL")
        return
    }
    
    let parameters: [String: Any] = [
        "username": username,
        "password": password  // Note: Passwords should be hashed and handled securely
    ]

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpkcnhjcnJwYXBuemRqZGhtZG5rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3OTkxNTUsImV4cCI6MjAyOTM3NTE1NX0.w0QyucJ9z65_rTuB2rHqVAKwCsmtm9jOTuMYhWVo33Q", forHTTPHeaderField: "Authorization")  // Replace YOUR_ANON_KEY with your Supabase anon key
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error occurred: \(error)")
            return
        }

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
            print("HTTP Error: \(httpResponse.statusCode)")
            return
        }

        print("User registered successfully")
    }.resume()
}


#Preview {
    ContentView()
}


