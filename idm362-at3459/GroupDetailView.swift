import SwiftUI

struct GroupDetailView: View {
    var group: Group
    @StateObject private var dataManager = DataManager.shared
    @State private var showAddExpenseSheet = false
    
    var expenses: [Expense] {
        dataManager.getExpenses(for: group.id)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                GroupSummaryCard(group: group, totalExpenses: group.totalAmount)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        SectionHeader(title: "Expenses")
                        Spacer()
                        Button(action: {
                            showAddExpenseSheet = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color.blue)
                        }
                    }
                    
                    if expenses.isEmpty {
                        HStack {
                            Spacer()
                            Text("No expenses yet")
                                .font(.custom("AvenirNext-Regular", size: 16))
                                .foregroundColor(Color("memberColor"))
                                .padding(.vertical)
                            Spacer()
                        }
                    } else {
                        ForEach(expenses) { expense in
                            ExpenseRow(expense: expense, onDelete: {
                                dataManager.deleteExpense(expense)
                            })
                        }
                    }
                }
                .padding()
                .background(Color("cardBgColor"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                if !expenses.isEmpty {
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
            }
            .padding()
        }
        .background(Color("bgColorApp").edgesIgnoringSafeArea(.all))
        .navigationTitle(group.name)
        .sheet(isPresented: $showAddExpenseSheet) {
            AddExpenseView(group: group)
        }
    }
    
    private func calculateOwedAmount(for member: String) -> Double {
        var amountOwed: Double = 0
        
        for expense in expenses {
            if expense.participants.contains(member) {
                // Calculate this member's share for this specific expense
                let participantCount = expense.participants.count
                let shareAmount = expense.amount / Double(participantCount)
                amountOwed += shareAmount
            }
        }
        
        return amountOwed
    }
}

struct GroupSummaryCard: View {
    let group: Group
    let totalExpenses: Double
    
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
                Text("$\(String(format: "%.2f", totalExpenses))")
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
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.custom("AvenirNext-Medium", size: 16))
                    .foregroundColor(Color("nameExpenseColor"))
                
                if !expense.participants.isEmpty {
                    Text(expense.participants.joined(separator: ", "))
                        .font(.custom("AvenirNext-Regular", size: 12))
                        .foregroundColor(Color("memberColor"))
                }
            }
            
            Spacer()
            
            Text("$\(String(format: "%.2f", expense.amount))")
                .font(.custom("DINAlternate-Bold", size: 18))
                .foregroundColor(Color("priceExpenseColor"))
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
            }
            .padding(.leading, 8)
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
