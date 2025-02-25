import Foundation
import SwiftUI

struct Group: Identifiable, Codable {
    var id = UUID()
    var name: String
    var members: [String]
    var totalAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, members, totalAmount
    }
    
    init(name: String, members: [String], totalAmount: Double) {
        self.name = name
        self.members = members
        self.totalAmount = totalAmount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        members = try container.decode([String].self, forKey: .members)
        totalAmount = try container.decode(Double.self, forKey: .totalAmount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(members, forKey: .members)
        try container.encode(totalAmount, forKey: .totalAmount)
    }
}

struct Expense: Identifiable, Codable {
    var id = UUID()
    var title: String
    var amount: Double
    var participants: [String]
    var groupId: UUID
    
    enum CodingKeys: String, CodingKey {
        case id, title, amount, participants, groupId
    }
    
    init(title: String, amount: Double, participants: [String], groupId: UUID) {
        self.title = title
        self.amount = amount
        self.participants = participants
        self.groupId = groupId
    }
}

class DataManager: ObservableObject {
    @Published var groups: [Group] = []
    @Published var allExpenses: [Expense] = []
    
    static let shared = DataManager()
    
    private let groupsKey = "savedGroups"
    private let expensesKey = "savedExpenses"
    
    init() {
        loadData()
    }
    
    
    func addGroup(_ group: Group) {
        groups.append(group)
        saveGroups()
    }
    
    func updateGroup(_ group: Group) {
        if let index = groups.firstIndex(where: { $0.id == group.id }) {
            groups[index] = group
            saveGroups()
        }
    }
    
    func deleteGroup(at offsets: IndexSet) {
        let groupIdsToDelete = offsets.map { groups[$0].id }
        allExpenses.removeAll(where: { groupIdsToDelete.contains($0.groupId) })
        
        groups.remove(atOffsets: offsets)
        
        saveGroups()
        saveExpenses()
    }
    
    
    func addExpense(_ expense: Expense) {
        allExpenses.append(expense)
        updateGroupTotal(groupId: expense.groupId)
        saveExpenses()
    }
    
    func updateExpense(_ expense: Expense) {
        if let index = allExpenses.firstIndex(where: { $0.id == expense.id }) {
            allExpenses[index] = expense
            updateGroupTotal(groupId: expense.groupId)
            saveExpenses()
        }
    }
    
    func deleteExpense(_ expense: Expense) {
        allExpenses.removeAll(where: { $0.id == expense.id })
        updateGroupTotal(groupId: expense.groupId)
        saveExpenses()
    }
    
    func getExpenses(for groupId: UUID) -> [Expense] {
        return allExpenses.filter { $0.groupId == groupId }
    }
    
    private func updateGroupTotal(groupId: UUID) {
        let groupExpenses = getExpenses(for: groupId)
        let total = groupExpenses.reduce(0) { $0 + $1.amount }
        
        if let index = groups.firstIndex(where: { $0.id == groupId }) {
            groups[index].totalAmount = total
            saveGroups()
        }
    }
    
    
    private func saveGroups() {
        if let encoded = try? JSONEncoder().encode(groups) {
            UserDefaults.standard.set(encoded, forKey: groupsKey)
        }
    }
    
    private func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(allExpenses) {
            UserDefaults.standard.set(encoded, forKey: expensesKey)
        }
    }
    
    private func loadData() {
        if let groupsData = UserDefaults.standard.data(forKey: groupsKey),
           let decodedGroups = try? JSONDecoder().decode([Group].self, from: groupsData) {
            groups = decodedGroups
        }
        
        if let expensesData = UserDefaults.standard.data(forKey: expensesKey),
           let decodedExpenses = try? JSONDecoder().decode([Expense].self, from: expensesData) {
            allExpenses = decodedExpenses
        }
    }
}
