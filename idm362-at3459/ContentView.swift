//
//  ContentView.swift
//  idm362-at3459
//
//  Created by Anuj Tanwar on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var buttonTapped = false
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack {
                Text("IDM362 Homework")
                    .font(.custom("Avenir-Heavy", size: 24))
                    .foregroundColor(.blue)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                    )
                Image("HeadShot")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                
                Text("Anuj Tanwar")
                    .font(.custom("Avenir-Heavy", size: 20))
                    .foregroundColor(.red)
                Button(action: {
                    print("Button tapped!")
                }) {
                    Text("Click Me")
                        .font(.custom("Avenir-Heavy", size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
