import SwiftUI

struct ContentView: View {
    // Color definitions
    private let backgroundColorLight = Color(red: 0.98, green: 0.97, blue: 0.95)
    private let backgroundColorDark = Color(red: 0.13, green: 0.12, blue: 0.15)
    private let cardBackgroundLight = Color(red: 1.0, green: 1.0, blue: 1.0)
    private let cardBackgroundDark = Color(red: 0.18, green: 0.17, blue: 0.20)
    private let accentColor = Color.blue
    private let secondaryAccentColor = Color(red: 1.0, green: 0.3, blue: 0.5)
    private let totalPriceColor = Color(red: 0.3, green: 0.7, blue: 0.3)
    private let titleColorLight = Color(red: 0.27, green: 0.11, blue: 0.30)
    private let titleColorDark = Color(red: 0.91, green: 0.72, blue: 0.95)
    private let memberColorLight = Color(red: 0.08, green: 0.18, blue: 0.27)
    private let memberColorDark = Color(red: 0.56, green: 0.80, blue: 0.99)

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
                            GroupCard(group: group, cardBackgroundColor: cardBackgroundColor,
                                  totalPriceColor: totalPriceColor,
                                      groupTitleColor: groupTitleColor,
                                      memberTextColor:memberTextColor)
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
                                .font(.custom("AvenirNext-DemiBold", size: 20))
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
            .navigationBarTitleDisplayMode(.large)
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
    
    private var groupTitleColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.titleColorDark) : UIColor(self.titleColorLight)
        })
    }
    
    private var memberTextColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.memberColorDark) : UIColor(self.memberColorLight)
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
    let totalPriceColor: Color
    let groupTitleColor : Color
    let memberTextColor: Color
    
    var body: some View {
        NavigationLink(destination: GroupDetailView()) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(group.name)
                        .font(.custom("AvenirNext-DemiBold", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(groupTitleColor)
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(memberTextColor)
                        
                        Text(group.members.joined(separator: ", "))
                            .font(.custom("AvenirNext-Regular", size: 14))
                            .foregroundColor(memberTextColor)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    HStack {
                        Text("Total:")
                            .font(.custom("AvenirNext-Medium", size: 16))
                            .foregroundColor(.secondary)
                        Text("$\(String(format: "%.2f", group.totalAmount))")
                            .foregroundColor(totalPriceColor)
                            .font(.custom("DINAlternate-Bold", size: 18))
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardBackgroundColor)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
}

