import SwiftUI

struct FaceIDView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        Text("Face ID & Passcode Content")
                    } label: {
                        HStack {
                            Text("Setup Passcode")
                        }
                    }
                }
                Section {
                    Button {
                        print("Delete Passcode")
                    } label: {
                        HStack {
                            Text("Delete Passcode")
                                .foregroundStyle(Color(.red))
                        }
                    }
                }
            }
            .navigationTitle("Face ID & Passcode")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FaceIDView()
}
