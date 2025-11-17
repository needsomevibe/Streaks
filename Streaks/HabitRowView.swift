import SwiftUI

// MARK: - HabitRowView
struct HabitRowView: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Label {
                    Text(habit.title)
                        .font(.headline)
                } icon: {
                    Text(habit.icon)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(habit.color.opacity(0.85))
                        .clipShape(Circle())
                        .accessibilityHidden(true)
                }
                .labelStyle(.titleAndIcon)
                
                Spacer()
                
                ProgressView(value: habit.progressFraction)
                    .progressViewStyle(.circular)
                    .tint(habit.color)
                    .frame(width: 24, height: 24)
                    .accessibilityLabel("Completion")
                    .accessibilityValue("\(Int(habit.progressFraction * 100)) percent")
            }
            
            HabitDotGrid(
                color: habit.color,
                totalDots: habit.targetDays,
                completedDots: habit.completedDays
            )
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

// MARK: - HabitDotGrid (Сетка точек)
struct HabitDotGrid: View {
    let color: Color
    let totalDots: Int
    let completedDots: Int
    
    private var clampedCompletedDots: Int {
        min(max(completedDots, .zero), totalDots)
    }
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 4), count: 10)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(0..<totalDots, id: \.self) { index in
                Circle()
                    .fill(index < clampedCompletedDots ? color : color.opacity(0.25))
                    .frame(width: 6, height: 6)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: clampedCompletedDots)
    }
}
