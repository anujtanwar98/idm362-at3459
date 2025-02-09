import SwiftUI

struct AddExpenseView: View {
    private let backgroundColorLight = Color(red: 0.98, green: 0.97, blue: 0.95)
    private let backgroundColorDark = Color(red: 0.13, green: 0.12, blue: 0.15)
    private let textInputBackgroundLight = Color(red: 1.0, green: 1.0, blue: 1.0)
    private let textInputBackgroundDark = Color(red: 0.18, green: 0.17, blue: 0.20)
    private let textColorLight = Color(red: 0.27, green: 0.11, blue: 0.30)
    private let textColorDark = Color(red: 0.91, green: 0.72, blue: 0.95)
    private let memberColorLight = Color(red: 0.08, green: 0.18, blue: 0.27)
    private let memberColorDark = Color(red: 0.56, green: 0.80, blue: 0.99)
    private let headerTextColorLight = Color(red: 0.4, green: 0.4, blue: 0.4)
    private let headerTextColorDark = Color(red: 0.6, green: 0.6, blue: 0.6)
    
    @Environment(\.presentationMode) var presentationMode
    @State private var expenseName: String = ""
    @State private var amount: String = ""
    @State private var selectedMembers: Set<String> = []
    let availableMembers = ["Ask", "Assa"]
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                Form {
                    Section(header: Text("Expense Details")) {
                        TextField("Expense name", text: $expenseName)
                            .foregroundColor(textColor)
                            .font(.custom("AvenirNext-Medium", size: 16))
                        
                        TextField("Amount", text: $amount)
                            .foregroundColor(textColor)
                            .font(.custom("AvenirNext-Medium", size: 16))
                            .keyboardType(.decimalPad)
                    }
                    .listRowBackground(textInputBackgroundColor)
                    
                    Section(header: Text("Split Between")) {
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
                            .foregroundColor(memberTextColor)
                        }
                    }
                    .listRowBackground(textInputBackgroundColor)
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
    
    
    private var backgroundColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.backgroundColorDark) : UIColor(self.backgroundColorLight)
        })
    }
    
    private var textColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.textColorDark) : UIColor(self.textColorLight)
        })
    }
    
    private var memberTextColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.memberColorDark) : UIColor(self.memberColorLight)
        })
    }
    
    private var textInputBackgroundColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.textInputBackgroundDark) : UIColor(self.textInputBackgroundLight)
        })
    }
    
    private var headerTextColor: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(self.headerTextColorDark) : UIColor(self.headerTextColorLight)
        })
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

