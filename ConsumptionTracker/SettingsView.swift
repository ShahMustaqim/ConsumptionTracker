//
//  SettingsView.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 22/04/2026.
//

import SwiftUI

struct SettingsView: View {
    //permanently saves these numbers to device settings
    @AppStorage("waterTarget") var waterTarget: Int = 2000
    @AppStorage("calorieTarget") var calorieTarget:Int = 2000
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Daily Targets")){
                    Stepper("Water Target: \(waterTarget) mL", value: $waterTarget, in: 500...5000, step: 250)
                    Stepper("Calorie Target: \(calorieTarget) kcal", value: $calorieTarget, in: 500...5000, step: 100)
                }
                
                Section(header:Text("Target Health Check")){
                    if calorieTarget < 1200{
                        Text("Warning: Your calorie target is dangerously low. Please consult before doing so.")
                            .foregroundStyle(.red)
                            .bold()
                    } else if calorieTarget > 4000{
                        Text("Warning: Your calorie target is too high. Make sure your diet is balanced with exercise.")
                            .foregroundStyle(.orange)
                            .bold()
                    } else{
                        Text("Your target looks healthy and balanced.")
                            .foregroundStyle(.green)
                            .bold()
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
