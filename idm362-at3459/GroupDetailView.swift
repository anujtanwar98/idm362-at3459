import SwiftUI

struct GroupDetailView: View {
    let group = Group(name: "Weekend Getaway", members: ["Alex", "Bob", "Charlie", "David"], totalAmount: 1250)
    let expenses = [
        Expense(title: "Lunch", amount: 400),
        Expense(title: "Dinner", amount: 200),
        Expense(title: "Car Rental", amount: 300),
        Expense(title: "Activities", amount: 150)
    ]
    
    // Color definitions
    private let backgroundColorLight = Color(red: 0.98, green: 0.97, blue: 0.95)
    private let backgroundColorDark = Color(red: 0.13, green: 0.12, blue: 0.15)
    private let cardBackgroundLight = Color(red: 1.0, green: 1.0, blue: 1.0)
    private let cardBackgroundDark = Color(red: 0.18, green: 0.17, blue: 0.20)
    private let accentColor = Color.blue
    private let secondaryAccentColor = Color(red: 1.0, green: 0.3, blue: 0.5)
    private let titleColorLight = Color(red: 0.27, green: 0.11, blue: 0.30)
    private let titleColorDark = Color(red: 0.91, green: 0.72, blue: 0.95)
    private let memberColorLight = Color(red: 0.08, green: 0.18, blue: 0.27)
    private let memberColorDark = Color(red: 0.56, green: 0.80, blue: 0.99)
    private let totalPriceColor = Color(red: 0.3, green: 0.7, blue: 0.3)

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                GroupSummaryCard(group: group, memberTextColor: memberTextColor,
                    groupTitleColor: groupTitleColor,
                    totalPriceColor: totalPriceColor)
                
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Expenses")
                    
                    ForEach(expenses) { expense in
                        ExpenseRow(expense: expense)
                    }
                }
                .padding()
                .background(cardBackgroundColor)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Amount Owed")
                    
                    ForEach(group.members, id: \.self) { member in
                        OwedRow(member: member, amount: calculateOwedAmount(for: member))
                    }
                }
                .padding()
                .background(cardBackgroundColor)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            }
            .padding()
        }
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
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
    
    private var memberTextColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.memberColorDark) : UIColor(self.memberColorLight)
        })
    }
    
    private var groupTitleColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.titleColorDark) : UIColor(self.titleColorLight)
        })
    }
    
    private func calculateOwedAmount(for member: String) -> Double {
        let averageOwed = group.totalAmount / Double(group.members.count)
        return averageOwed
    }
}

struct GroupSummaryCard: View {
    let group: Group
    let memberTextColor: Color
    let groupTitleColor : Color
    let totalPriceColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(group.name)
                .font(.custom("AvenirNext-Bold", size: 28))
                .foregroundColor(groupTitleColor)
            
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(memberTextColor)
                Text(group.members.joined(separator: ", "))
                    .font(.custom("AvenirNext-Regular", size: 16))
                    .foregroundColor(memberTextColor)
            }
            
            HStack {
                Text("Total")
                    .font(.custom("AvenirNext-Medium", size: 18))
                    .foregroundColor(.secondary)
                Spacer()
                Text("$\(String(format: "%.2f", group.totalAmount))")
                    .font(.custom("DINAlternate-Bold", size: 24))
                    .foregroundColor(totalPriceColor)
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
        )
    }
}

struct ExpenseRow: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.title)
                .font(.custom("AvenirNext-Medium", size: 16))
            Spacer()
            Text("$\(String(format: "%.2f", expense.amount))")
                .font(.custom("DINAlternate-Bold", size: 18))
                .foregroundColor(.blue)
        }
        .padding(.vertical, 8)
    }
}

struct OwedRow: View {
    let member: String
    let amount: Double
    
    var body: some View {
        HStack {
            Text(member)
                .font(.custom("AvenirNext-Medium", size: 16))
            Spacer()
            Text("$\(String(format: "%.2f", amount))")
                .font(.custom("DINAlternate-Bold", size: 18))
                .foregroundColor(.orange)
        }
        .padding(.vertical, 8)
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom("AvenirNext-DemiBold", size: 22))
            .foregroundColor(.primary)
    }
}

struct Expense: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
}

#Preview {
    NavigationView {
        GroupDetailView()
    }
}

