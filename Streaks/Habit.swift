import SwiftUI

// MARK: - Habit Model
struct Habit: Identifiable {
    let id: UUID
    var title: String
    var icon: String
    var color: Color
    var completedDays: Int
    var targetDays: Int
    
    init(
        id: UUID = UUID(),
        title: String,
        icon: String,
        color: Color,
        completedDays: Int = .zero,
        targetDays: Int = 30
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.color = color
        self.completedDays = completedDays
        self.targetDays = max(targetDays, 1)
    }
    
    var progressFraction: Double {
        guard targetDays > 0 else { return .zero }
        return min(Double(completedDays) / Double(targetDays), 1)
    }
}

extension Habit {
    static let samples: [Habit] = [
        Habit(title: "Run", icon: "🏃‍♂️", color: .mint, completedDays: 12, targetDays: 30),
        Habit(title: "Read", icon: "📚", color: .orange, completedDays: 5, targetDays: 14),
        Habit(title: "Meditate", icon: "🧘‍♀️", color: .purple, completedDays: 8, targetDays: 21)
    ]
}
