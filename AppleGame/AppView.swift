//
//  AppView.swift
//  AppleGame
//
//  Created by snulife on 2023/07/03.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 100)
                Image(systemName: "apple.logo")
                    .imageScale(.large)
                    .foregroundColor(.red)
                Text("Apple Game")
                    .padding(2)
                Spacer()
                    .frame(height: 70)
                NavigationLink(destination: ContentView()){
                    Text("Start!")
                        .frame(width: 100)
                        .padding(6)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.accentColor, lineWidth: 4))
                }
            }
            
        }
        .ignoresSafeArea()
        
    }
    
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
