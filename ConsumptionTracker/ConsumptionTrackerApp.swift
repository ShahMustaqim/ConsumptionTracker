//
//  ConsumptionTrackerApp.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 20/04/2026.
//

import SwiftUI
import SwiftData//so the file can access the database

@main
struct ConsumptionTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //container creation
        .modelContainer(for: DailyRecord.self)
    }
}
