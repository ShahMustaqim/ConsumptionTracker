//
//  HealthKitManager.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 21/04/2026.
//

import Foundation
import HealthKit
import SwiftUI
import Combine

class HealthKitManager: ObservableObject {
    // 1. The bridge to Apple Health
    let healthStore = HKHealthStore()
    
    // 2. The variable that will hold our steps so the screen can see it
    @Published var todaySteps: Double = 0.0
    
    // 3. The function to ask the user for permission
    func requestAuthorization() {
        // We only want to read the step count
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let readTypes: Set = [stepType]
        
        // Ask HealthKit for permission
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("Permission granted!")
                self.fetchTodaySteps()
            } else {
                print("Permission denied.")
            }
        }
    }
    
    // 4. The function to actually get the steps for today
    func fetchTodaySteps() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Could not read steps")
                return
            }
            
            // Update our variable on the main screen thread
            DispatchQueue.main.async {
                self.todaySteps = sum.doubleValue(for: HKUnit.count())
            }
        }
        
        healthStore.execute(query)
    }
}
