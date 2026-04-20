//
//  ConsumptionTrackerApp.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 20/04/2026.
//

import SwiftUI
import SwiftData

@main
struct ConsumptionTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DailyRecord.self)//create storage
    }
}
