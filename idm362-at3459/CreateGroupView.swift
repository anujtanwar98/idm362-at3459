import SwiftUI

struct CreateGroupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var groups: [Group]
    
    @State private var groupName = ""
    @State private var newMember = ""
    @State private var members: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("bgColorApp")
                    .edgesIgnoringSafeArea(.all)
                
            Form {
                Section(header: Text("Group Name")) {
                    TextField("Enter group name", text: $groupName)
                        .foregroundColor(Color("groupTitleColor"))
                        .font(.custom("AvenirNext-Medium", size: 16))
                }
                .listRowBackground(Color("cardBgColor"))
                
                Section(header: Text("Add Members")) {
                    HStack {
                        TextField("Enter member name", text: $newMember)
                            .foregroundColor(Color("memberColor"))
                        Button(action: addMember) {
                            Text(" Add")
                                .font(.custom("AvenirNext-DemiBold", size: 16))
                                .foregroundColor(Color("priceOweColor"))
                        }
                        .disabled(newMember.isEmpty)
                    }
                }
                .listRowBackground(Color("cardBgColor"))
                
                Section(header: Text("Members")) {
                    List {
                        ForEach(members, id: \.self) { member in
                            Text(member)
                                .foregroundColor(Color("memberColor"))
                        }
                        .onDelete(perform: deleteMember)
                    }
                }
                .listRowBackground(Color("cardBgColor"))
            }
            .scrollContentBackground(.hidden)
        }
            .navigationTitle("Create New Group")
            .foregroundColor(Color("groupTitleColor"))
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Create Group") {
                    saveGroup()
                }
                .disabled(groupName.isEmpty || members.isEmpty)
            )
        }
    }
    
    private func addMember() {
        if !newMember.isEmpty {
            members.append(newMember)
            newMember = ""
        }
    }
    
    private func deleteMember(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
    }
    
    private func saveGroup() {
        let newGroup = Group(name: groupName, members: members, totalAmount: 0)
        groups.append(newGroup)
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView(groups: .constant([]))
    }
}
