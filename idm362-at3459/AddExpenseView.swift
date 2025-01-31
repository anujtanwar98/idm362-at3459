import SwiftUI

struct AddExpenseView: View {
    @State private var expenseName: String = ""
    @State private var amount: String = ""
    @State private var splitWithAsk: Bool = false
    @State private var splitWithAssa: Bool = false
    
    // Color definitions matching the image
    private let backgroundColor = Color(red: 0.12, green: 0.12, blue: 0.12)
    private let textFieldBackground = Color(red: 0.2, green: 0.2, blue: 0.2)
    private let headerTextColor = Color(red: 0.6, green: 0.6, blue: 0.6)
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 24) {
                Text("Add Expense")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("EXPENSE DETAILS")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(headerTextColor)
                    
                    VStack(spacing: 16) {
                        TextField("Expense name", text: $expenseName)
                            .textFieldStyle(DarkTextFieldStyle())
                        
                        TextField("Amount", text: $amount)
                            .textFieldStyle(DarkTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("SPLIT BETWEEN")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(headerTextColor)
                    
                    VStack(spacing: 16) {
                        ToggleRow(member: "Ask", isOn: $splitWithAsk)
                        ToggleRow(member: "Assa", isOn: $splitWithAssa)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct DarkTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}

struct ToggleRow: View {
    let member: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(member)
                .foregroundColor(.white)
                .font(.system(size: 16))
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}

#Preview {
    AddExpenseView()
}
