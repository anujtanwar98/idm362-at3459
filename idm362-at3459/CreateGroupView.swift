//
//  CreateGroupView.swift
//  idm362-at3459
//
//  Created by Anuj Tanwar on 1/25/25.
//

import SwiftUI

struct CreateGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var groups: [Group]
    
    @State private var groupName = ""
    @State private var newMember = ""
    @State private var members: [String] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Group Name")) {
                    TextField("Enter group name", text: $groupName)
                }
                
                Section(header: Text("Add Members")) {
                    HStack {
                        TextField("Enter member name", text: $newMember)
                        Button(action: addMember) {
                            Text(" Add")
                        }
                        .disabled(newMember.isEmpty)
                    }
                }
                
                Section(header: Text("Members")) {
                    List {
                        ForEach(members, id: \.self) { member in
                            Text(member)
                        }
                        .onDelete(perform: deleteMember)
                    }
                }
            }
            .navigationTitle("Create New Group")
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

