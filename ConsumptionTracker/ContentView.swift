//
//  ContentView.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 20/04/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var records : [DailyRecord]// fetch record from database
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(records){ record in //looped thru every saved day
                    VStack(alignment: .leading){
                        Text(record.date, format: .dateTime.month().day())
                            .font(.headline)
                        
                        Text("Water: \(record.waterConsumed) mL | Food: \(record.caloriesConsumed) kcal")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("History")
            .toolbar{
                Button("Add Test Day"){
                    addTestRecord()
                }
            }
        }
    }
    func addTestRecord(){
        let newRecord = DailyRecord(date: Date.now, waterConsumed: 250, caloriesConsumed: 500)
        
            modelContext.insert(newRecord)
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
        .modelContainer(for:DailyRecord.self)
}
