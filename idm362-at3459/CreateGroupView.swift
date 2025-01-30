//
//  CreateGroupView.swift
//  idm362-at3459
//
//  Created by Anuj Tanwar on 1/25/25.
//

import SwiftUI

struct CreateGroupView: View {
    
    private let backgroundColorLight = Color(red: 0.98, green: 0.97, blue: 0.95)
    private let backgroundColorDark = Color(red: 0.13, green: 0.12, blue: 0.15)
    private let textInputBackgroundLight = Color(red: 1.0, green: 1.0, blue: 1.0)
    private let textInputBackgroundDark = Color(red: 0.18, green: 0.17, blue: 0.20)
    private let accentColor = Color.blue
    private let secondaryAccentColor = Color(red: 1.0, green: 0.3, blue: 0.5)
    private let memberColorLight = Color(red: 0.08, green: 0.18, blue: 0.27)
    private let memberColorDark = Color(red: 0.56, green: 0.80, blue: 0.99)
    private let textColorLight = Color(red: 0.27, green: 0.11, blue: 0.30)
    private let textColorDark = Color(red: 0.91, green: 0.72, blue: 0.95)
    
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var groups: [Group]
    
    @State private var groupName = ""
    @State private var newMember = ""
    @State private var members: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
            Form {
                Section(header: Text("Group Name")) {
                    TextField("Enter group name", text: $groupName)
                        .foregroundColor(textColor)
                        .font(.custom("AvenirNext-Medium", size: 16))
                }
                .listRowBackground(textInputBackgroundColor)
                
                Section(header: Text("Add Members")) {
                    HStack {
                        TextField("Enter member name", text: $newMember)
                            .foregroundColor(memberTextColor)
                        Button(action: addMember) {
                            Text(" Add")
                        }
                        .disabled(newMember.isEmpty)
                    }
                }
                .listRowBackground(textInputBackgroundColor)
                
                Section(header: Text("Members")) {
                    List {
                        ForEach(members, id: \.self) { member in
                            Text(member)
                                .foregroundColor(memberTextColor)
                        }
                        .onDelete(perform: deleteMember)
                    }
                }
                .listRowBackground(textInputBackgroundColor)
            }
            .scrollContentBackground(.hidden)
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
