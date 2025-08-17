//
//  EchoApp.swift
//  Echo
//
//  Created by Михайло Тихонов on 17.08.2025.
//

import SwiftUI
import SwiftData

@main
struct EchoApp: App {
    var body: some Scene {
        WindowGroup {
            JournalEntryListView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
