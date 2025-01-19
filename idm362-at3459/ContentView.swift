//
//  ContentView.swift
//  idm362-at3459
//
//  Created by Anuj Tanwar on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var buttonTapped = false
    @State private var showMessage = false
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
                    showMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showMessage = false
                    }
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
                if showMessage {
                    Text("Hello! how are you?")
                        .font(.custom("Avenir-Heavy", size: 16))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .transition(.opacity)
                        .animation(.easeInOut, value: showMessage)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
