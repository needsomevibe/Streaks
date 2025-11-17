import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let onAddHabit: (String, String, Color) -> Void
    
    // MARK: State Variables
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate: Date = Date()
    @State private var interval: String = "Daily"
    @State private var selectedDays: [DayOfWeek] = []
    @State private var reminderTime: Date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? Date()
    @State private var selectedColor: Color = .green
    @State private var icon: String = "#"
    
    let themes: [Color] = [.green, .brown, Color(.darkGray), .purple, .red, .pink, .blue, .teal, .orange]
    
    // MARK: - DayOfWeek Enum and Data
    enum DayOfWeek: String, CaseIterable, Identifiable {
        case mon, tue, wed, thu, fri, sat, sun
        var id: String { self.rawValue }
        var shortName: String {
            switch self {
            case .mon: return "Mon"
            case .tue: return "Tue"
            case .wed: return "Wed"
            case .thu: return "Thu"
            case .fri: return "Fri"
            case .sat: return "Sat"
            case .sun: return "Sun"
            }
        }
    }
    
    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var canAddHabit: Bool {
        !trimmedTitle.isEmpty
    }
    
    private var shouldShowTimePicker: Bool {
        !selectedDays.isEmpty
    }
    
    init(onAddHabit: @escaping (String, String, Color) -> Void = { _, _, _ in }) {
        self.onAddHabit = onAddHabit
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - INFO
                Section("INFO") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    
                    HStack {
                        Text("Select the start date")
                        Spacer()
                        DatePicker("", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                    }
                }
                
                // MARK: - STREAK GOAL & INTERVAL
                Section("STREAK GOAL & INTERVAL") {
                    Picker("Interval", selection: $interval) {
                        Text("Daily").tag("Daily")
                        Text("Weekly").tag("Weekly")
                        Text("Monthly").tag("Monthly")
                    }
                    .pickerStyle(.navigationLink)
                }
                
                // MARK: - REMINDER
                Section("REMINDER") {
                    HStack(spacing: 10) {
                        ForEach(DayOfWeek.allCases) { day in
                            DayButton(
                                day: day,
                                isSelected: selectedDays.contains(day),
                                action: { toggleDay(day) }
                            )
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .listRowBackground(Color.clear)
                    
                    if shouldShowTimePicker {
                        HStack {
                            Text("Pick a time")
                            Spacer()
                            DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                    }
                }
                
                // MARK: - THEME & ICON
                Section {
                    // Выбор темы (цвета)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(themes, id: \.self) { color in
                                ColorCircle(color: color, isSelected: color == selectedColor)
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                    // Выбор иконки
                    HStack {
                        Text("Pick an icon")
                        Spacer()
                        Text(icon)
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                            .onTapGesture {
                                // Здесь будет логика для открытия выбора иконки
                                print("Pick an icon tapped")
                            }
                    }
                }
                .textCase(nil)
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        onAddHabit(trimmedTitle, icon, selectedColor)
                        dismiss()
                    }
                    .disabled(!canAddHabit)
                    .bold()
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    func toggleDay(_ day: DayOfWeek) {
        if selectedDays.contains(day) {
            selectedDays.removeAll { $0 == day }
        } else {
            selectedDays.append(day)
        }
    }
}

// MARK: - Reusable Components

struct DayButton: View {
    let day: NewHabitView.DayOfWeek
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(day.shortName)
                .font(.caption.bold())
                .frame(width: 35, height: 35)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(day.shortName)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct ColorCircle: View {
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 35, height: 35)
            .overlay(
                // Условное отображение белого круга внутри, если цвет выбран
                isSelected ?
                Circle()
                    .fill(Color.white) // Белый цвет внутреннего круга
                    .frame(width: 8, height: 8) // Размер внутреннего круга
                : nil
            )
            // Добавим обводку вокруг самого круга для лучшего выделения (опционально)
            .overlay(
                Circle()
                    .stroke(Color(.separator), lineWidth: 0.5) // Тонкая серая обводка
            )
    }
}

#Preview {
    NewHabitView()
}
