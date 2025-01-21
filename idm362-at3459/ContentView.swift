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
            Color(red: 1.0, green: 0.976, blue: 0.941).edgesIgnoringSafeArea(.all)
            VStack {
                Text("IDM362 Homework")
                    .font(.custom("Avenir-Heavy", size: 18))
                    .foregroundColor(Color(red: 0.125, green: 0.188, blue: 0.161))
                    .padding(8)
//                    .background(
//                        RoundedRectangle(cornerRadius: 8)
//                        .fill(Color(red: 0.008, green: 0.286, blue: 0.157))
//                    )
                Image("HeadShot")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                
                Text("Anuj Tanwar")
                    .font(.custom("Avenir-Heavy", size: 20))
                    .foregroundColor(Color(red: 0.267, green: 0.110, blue: 0.298))
                Button(action: {
                    showMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showMessage = false
                    }
                }) {
                    Text("Click Me")
                        .font(.custom("Avenir-Heavy", size: 14))
                        .foregroundColor(Color(red: 1.0, green: 0.976, blue: 0.941))
                        .padding(10)
                        .background(Color(red: 0.008, green: 0.286, blue: 0.157))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                .padding(.top, -5)
                if showMessage {
                    Text("Hello! how are you?")
                        .font(.custom("Avenir-Heavy", size: 14))
                        .foregroundColor(Color(red: 0.267, green: 0.110, blue: 0.298))
                        .padding(5)
                        .background(Color(red: 0.906, green: 0.718, blue: 0.945))
                        .cornerRadius(8)
                        .transition(.opacity)
                        .animation(.easeInOut, value: showMessage)
                }
//                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
