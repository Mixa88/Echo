//
//  AddEntryView.swift
//  Echo
//
//  Created by Михайло Тихонов on 17.08.2025.
//

import SwiftUI
import SwiftData

struct AddEntryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedMood: JournalEntry.Mood?
    @State private var creationDate = Date.now
    @State private var note: String = ""
    
    private var isSaveDisabled: Bool {
        selectedMood == nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What's your mood?") {
                    HStack(spacing: 15) {
                        ForEach(JournalEntry.Mood.allCases, id: \.self) { mood in
                            Button(action: {
                                selectedMood = mood
                            }) {
                                Text(mood.rawValue)
                                    .font(.largeTitle)
                                    .scaleEffect(selectedMood == mood ? 1.5 : 1)
                                    .animation(.bouncy, value: selectedMood)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Section("Your note") {
                    TextEditor(text: $note)
                        .frame(maxHeight: 150)
                }
                
                Section("Date") {
                    DatePicker("Creation date", selection: $creationDate, displayedComponents: .date)
                }
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: saveEntry)
                        .disabled(isSaveDisabled)
                    
                }
            }
        }
    }
    
    func saveEntry() {
        guard let mood = selectedMood else { return }
        
        let newEntry = JournalEntry(creationDate: creationDate, mood: mood, note: note)
        
        modelContext.insert(newEntry)
        
        dismiss()
        
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: JournalEntry.self, configurations: .init(isStoredInMemoryOnly: true))
        
        return AddEntryView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
