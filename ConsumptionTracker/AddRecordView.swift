//
//  AddRecordView.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 20/04/2026.
//

import SwiftUI
import SwiftData

struct AddRecordView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query var records : [DailyRecord]
    
    @State private var waterInput: String = ""
    @State private var calorieInput : String = ""
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Water consumed (mL)", text: $waterInput)
                    .keyboardType(.numberPad)//num keybpad
                
                TextField("Calories consumed (kcal)", text: $calorieInput)
                    .keyboardType(.numberPad)
                
                Button("Save Record"){
                    let water = Int(waterInput) ?? 0 //default 0 if empty
                    let calories = Int(calorieInput) ?? 0
                    
                    //search records for today's data
                    if let todayRecord = records.first(where:{Calendar.current.isDate($0.date, inSameDayAs: Date.now)}){
                        //if found, add the numbers
                        todayRecord.waterConsumed += water
                        todayRecord.caloriesConsumed += calories
                    }else{
                        //if not found, create new data
                        let newRecord = DailyRecord(date: Date.now, waterConsumed:water, caloriesConsumed: calories)
                        modelContext.insert(newRecord)
                    }
                    try? modelContext.save()//save changes
                    dismiss() //close screen
                }
            }
            .navigationTitle(Text("Add Record"))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Close"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddRecordView()
        .modelContainer(for: DailyRecord.self)
}
