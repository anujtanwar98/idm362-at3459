import SwiftUI

struct GroupDetailView: View {
    let group = Group(name: "Weekend Getaway", members: ["Alex", "Bob", "Charlie", "David"], totalAmount: 1250)
    let expenses = [
        Expense(title: "Lunch", amount: 400),
        Expense(title: "Dinner", amount: 200),
        Expense(title: "Car Rental", amount: 300),
        Expense(title: "Activities", amount: 150)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                GroupSummaryCard(group: group)
                
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Expenses")
                    
                    ForEach(expenses) { expense in
                        ExpenseRow(expense: expense)
                    }
                }
                .padding()
                .background(Color("cardBgColor"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Amount Owed")
                    
                    ForEach(group.members, id: \.self) { member in
                        OwedRow(member: member, amount: calculateOwedAmount(for: member))
                    }
                }
                .padding()
                .background(Color("cardBgColor"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            }
            .padding()
        }
        .background(Color("bgColorApp").edgesIgnoringSafeArea(.all))
    }
    
    private func calculateOwedAmount(for member: String) -> Double {
        let averageOwed = group.totalAmount / Double(group.members.count)
        return averageOwed
    }
}

struct GroupSummaryCard: View {
    let group: Group
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(group.name)
                .font(.custom("AvenirNext-Bold", size: 28))
                .foregroundColor(Color("groupTitleColor"))
            
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(Color("memberColor"))
                Text(group.members.joined(separator: ", "))
                    .font(.custom("AvenirNext-Regular", size: 16))
                    .foregroundColor(Color("memberColor"))
            }
            
            HStack {
                Text("Total")
                    .font(.custom("AvenirNext-Medium", size: 18))
                    .foregroundColor(Color("priceColor"))
                Spacer()
                Text("$\(String(format: "%.2f", group.totalAmount))")
                    .font(.custom("DINAlternate-Bold", size: 24))
                    .foregroundColor(Color("priceColor"))
            }
        }
        .padding()
        .background(Color("cardBgColor"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue.opacity(0.8), lineWidth: 1)
        )
    }
}

struct ExpenseRow: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.title)
                .font(.custom("AvenirNext-Medium", size: 16))
                .foregroundColor(Color("nameExpenseColor"))
            Spacer()
            Text("$\(String(format: "%.2f", expense.amount))")
                .font(.custom("DINAlternate-Bold", size: 18))
                .foregroundColor(Color("priceExpenseColor"))
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
                .foregroundColor(Color("nameMemberColor"))
            Spacer()
            Text("$\(String(format: "%.2f", amount))")
                .font(.custom("DINAlternate-Bold", size: 18))
                .foregroundColor(Color("priceOweColor"))
        }
        .padding(.vertical, 8)
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom("AvenirNext-DemiBold", size: 22))
            .foregroundColor(Color("groupTitleColor"))
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

