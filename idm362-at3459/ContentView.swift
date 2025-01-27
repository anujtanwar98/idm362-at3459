//
//  ContentView.swift
//  idm362-at3459
//
//  Created by Anuj Tanwar on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    // Color definitions
    private let backgroundColorLight = Color(red: 0.95, green: 0.95, blue: 0.97)
    private let backgroundColorDark = Color(red: 0.11, green: 0.11, blue: 0.12)
    private let cardBackgroundLight = Color.white
    private let cardBackgroundDark = Color(red: 0.17, green: 0.17, blue: 0.18)
    private let accentColor = Color.blue
    private let secondaryAccentColor = Color(red: 1.0, green: 0.3, blue: 0.5)

    @State private var groups: [Group] = [
        Group(name: "Weekend Getaway", members: ["Alex", "Bob", "David"], totalAmount: 1250),
        Group(name: "Dinner Party", members: ["Joe", "Frank", "Grace"], totalAmount: 320),
        Group(name: "Road Trip", members: ["Kevin", "Lee", "Mia"], totalAmount: 780)
    ]
    
    @State private var showNewGroupSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(groups) { group in
                            GroupCard(group: group, cardBackgroundColor: cardBackgroundColor)
                                .transition(.scale)
                        }
                    }
                    .padding()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showNewGroupSheet = true
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [accentColor, secondaryAccentColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .clipShape(Circle())
                                .shadow(color: accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("FairShare")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showNewGroupSheet) {
            CreateGroupView(groups: $groups)
        }
    }
    
    private var backgroundColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.backgroundColorDark) : UIColor(self.backgroundColorLight)
        })
    }
    
    private var cardBackgroundColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.cardBackgroundDark) : UIColor(self.cardBackgroundLight)
        })
    }
}

struct Group: Identifiable {
    let id = UUID()
    let name: String
    let members: [String]
    let totalAmount: Double
}

struct GroupCard: View {
    let group: Group
    let cardBackgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(group.name)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Image(systemName: "person.3.fill")
            
            .foregroundColor(.secondary)
            
            Text(group.members.joined(separator: ", "))
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
            }
            
            HStack {
                Text("Total: $\(String(format: "%.2f", group.totalAmount))")
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackgroundColor)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        
        ContentView()
            .preferredColorScheme(.dark)
    }
}

