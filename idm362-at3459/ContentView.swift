import SwiftUI

struct ContentView: View {
    // Color definitions
    private let accentColor = Color.blue
    private let secondaryAccentColor = Color(red: 1.0, green: 0.3, blue: 0.5)

    @State private var groups: [Group] = [
        Group(name: "Weekend Getaway", members: ["Alex", "Bob", "David"], totalAmount: 0),
        Group(name: "Dinner Party", members: ["Joe", "Frank", "Grace"], totalAmount: 0),
        Group(name: "Road Trip", members: ["Kevin", "Lee", "Mia"], totalAmount: 0)
    ]
    
    @State private var showNewGroupSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("bgColorApp")
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    ForEach(groups) { group in
                        GroupCard(group: group)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, 10)
                    }
                    .onDelete(perform: deleteGroups)
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
                
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
    
    private func deleteGroups(at offsets: IndexSet) {
        groups.remove(atOffsets: offsets)
    }
}

struct Group: Identifiable {
    let id = UUID()
    let name: String
    let members: [String]
    var totalAmount: Double
}

struct GroupCard: View {
    let group: Group
    
    var body: some View {
        ZStack {
                    NavigationLink(destination: GroupDetailView(group: group)) {
                        EmptyView()
                    }
                    .opacity(0)
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(group.name)
                        .font(.custom("AvenirNext-DemiBold", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("groupTitleColor"))
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(Color("memberColor"))
                        
                        Text(group.members.joined(separator: ", "))
                            .font(.custom("AvenirNext-Regular", size: 14))
                            .foregroundColor(Color("memberColor"))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    HStack {
                        Text("Total:")
                            .font(.custom("AvenirNext-Medium", size: 16))
                            .foregroundColor(Color("priceColor"))
                        Text("$\(String(format: "%.2f", group.totalAmount))")
                            .foregroundColor(Color("priceColor"))
                            .font(.custom("DINAlternate-Bold", size: 18))
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color("memberColor"))
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("cardBgColor"))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .listRowSeparator(.hidden)
    }
}

#Preview {
    ContentView()
}
