import SwiftUI

struct HabitTab: View {
    @State private var isShowingNewHabitView = false
    @State private var habits: [Habit] = Habit.samples
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if habits.isEmpty {
                        ContentUnavailableView(
                            "No habits yet",
                            systemImage: "checkmark.circle",
                            description: Text("Tap “Add” to create your first habit.")
                        )
                    } else {
                        ForEach(habits) { habit in
                            HabitRowView(habit: habit)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingNewHabitView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add habit")
                }
            }
            .sheet(isPresented: $isShowingNewHabitView) {
                NewHabitView(onAddHabit: { title, icon, color in
                    addHabit(title: title, icon: icon, color: color)
                })
            }
            .animation(.easeInOut, value: habits.count)
        }
    }
    
    private func addHabit(title: String, icon: String, color: Color) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newHabit = Habit(title: title, icon: icon, color: color)
        habits.append(newHabit)
    }
}

struct SettingsTab: View {
    @State private var weekStartsOnSunday = false
    @State private var themeSelection = 0
    @State private var analyticsEnabled = true
    
    let theme = ["System Default", "Light", "Dark"]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // MARK: - Toggle
                    HStack {
                        iconView(systemName: "calendar", color: .green)
                        Toggle("Week starts on Sunday", isOn: $weekStartsOnSunday)
                    }

                    // MARK: - Open App Settings
                    Button {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack {
                            iconView(systemName: "gear", color: .blue)
                            Text("System Settings")

                        }
                    }

                    // MARK: - Picker with Icon
                    HStack {
                        iconView(systemName: "paintpalette", color: .cyan)
                        Text("Theme")
                        Spacer()
                        Picker("", selection: $themeSelection) {
                            ForEach(theme.indices, id: \.self) { index in
                                Text(theme[index])
                                    
                            }
                            
                        }
                        .pickerStyle(.menu)
                        .tint(.gray)
                        
                    }

                    // MARK: - Navigation Link
                    NavigationLink {
                        Text("Archived Habits Screen")
                    } label: {
                        HStack {
                            iconView(systemName: "archivebox", color: .orange)
                            Text("Archived Habits")
                        }
                    }
                    // MARK: - Import/Export Data
                    NavigationLink {
                        Text("Import/Export Data")
                    } label: {
                        HStack {
                            iconView(systemName: "document.fill", color: .blue)
                            Text("Import/Export Data")
                        }
                    }
                    // MARK: - App Icon
                    NavigationLink {
                        Text("")
                    } label: {
                        HStack {
                            iconView(systemName: "app", color: .blue)
                            Text("App Icon")
                            Spacer()
                            Text("Default")
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                    // MARK: - Face ID & Passcode
                    NavigationLink {
                        FaceIDView()
                    } label: {
                        HStack {
                            iconView(systemName: "faceid", color: .green)
                            Text("Face ID & Passcode")
                        }
                    }
                    
                }
                Section {
                    // MARK: - Write a review Button
                    Button {
                        print("Write Review Tapped")
                    } label: {
                        HStack {
                            iconView(systemName: "star", color: .blue)
                            Text("Write a Review")
                        }
                    }
                    // MARK: - Share Button
                    Button {
                        print("Share Button Tapped")
                    } label: {
                        HStack {
                            iconView(systemName: "square.and.arrow.up", color: .blue)
                            Text("Share")
                        }
                    }
                    // MARK: - Send Feedback
                    Button {
                        print("Send Feedback")
                    } label: {
                        HStack {
                            iconView(systemName: "rectangle.inset.filled", color: .blue)
                            Text("Send Feedback")
                        }
                    }
                }
                Section {
                    // MARK: - Privacy Policy
                    Button {
                        print("Privacy Policy Tapped")
                    } label: {
                        HStack {
                            iconView(systemName: "lock", color: .green)
                            Text("Privacy Policy")
                        }
                    }
                    // MARK: - Terms & Conditions
                    Button {
                        print("Terms & Conditions tapped")
                    } label: {
                        HStack {
                            iconView(systemName: "hand.raised", color: .green)
                            Text("Terms & Conditions")
                        }
                    }
                }
                Section {
                     VStack(alignment: .leading) {
                         Toggle("Analytics", isOn: $analyticsEnabled)
                         
                         Text("No data is linked to you. More in the Privacy Policy.")
                             .font(.caption)
                             .foregroundStyle(.gray)
                             .padding(.top, 1)
                     }
                 }
             }
             .navigationTitle("Settings")
         }
     }

    // MARK: - Reusable Icon View
    @ViewBuilder
    func iconView(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .foregroundColor(.white)
            .font(.system(size: 15))
            .frame(width: 30, height: 30)
            .background(color)
            .cornerRadius(8)
    }
}

struct ContentView: View {
    private enum Tab: Hashable {
        case habits, settings
    }
    
    @State private var selectedTab: Tab = .habits

    var body: some View {
        TabView(selection: $selectedTab) {
            HabitTab()
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Habits")
                }
                .tag(Tab.habits)

            SettingsTab()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
}
