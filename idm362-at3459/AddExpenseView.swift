import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var expenseName: String = ""
    @State private var amount: String = ""
    @State private var selectedMembers: Set<String> = []
    let availableMembers = ["Ask", "Assa"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("bgColorApp")
                    .edgesIgnoringSafeArea(.all)
                
                Form {
                    Section(header: Text("Expense Details").foregroundColor(Color("groupTitleColor"))) {
                        TextField("Expense name", text: $expenseName)
                            .foregroundColor(Color("groupTitleColor"))
                            .font(.custom("AvenirNext-Medium", size: 16))
                        
                        TextField("Amount", text: $amount)
                            .foregroundColor(Color("priceColor"))
                            .font(.custom("AvenirNext-Medium", size: 16))
                            .keyboardType(.decimalPad)
                    }
                    .listRowBackground(Color("cardBgColor"))
                    
                    Section(header: Text("Split Between").foregroundColor(Color("groupTitleColor"))) {
                        ForEach(availableMembers, id: \.self) { member in
                            Toggle(member, isOn: Binding(
                                get: { selectedMembers.contains(member) },
                                set: { isSelected in
                                    if isSelected {
                                        selectedMembers.insert(member)
                                    } else {
                                        selectedMembers.remove(member)
                                    }
                                }
                            ))
                            .foregroundColor(Color("memberColor"))
                        }
                    }
                    .listRowBackground(Color("cardBgColor"))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add Expense")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveExpense()
                }
                .disabled(expenseName.isEmpty || amount.isEmpty || selectedMembers.isEmpty)
            )
        }
    }
    
    private func saveExpense() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}

