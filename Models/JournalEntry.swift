//
//  JournalEntry.swift
//  Echo
//
//  Created by Михайло Тихонов on 17.08.2025.
//

import Foundation
import SwiftData

@Model
class JournalEntry: Identifiable {
    var id = UUID()
    var creationDate: Date
    var mood: Mood
    var note: String
    var audioFileName: String?
    
    init(id: UUID = UUID(), creationDate: Date, mood: Mood, note: String, audioFileName: String? = nil) {
        self.id = id
        self.creationDate = creationDate
        self.mood = mood
        self.note = note
        self.audioFileName = audioFileName
    }
    
    enum Mood: String, CaseIterable, Codable {
        case happy = "😊"
        case sad = "😢"
        case calm = "😌"
        
    }
}
