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
    
    @State private var showingAddForm: Bool = false
    
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
                ToolbarItem(placement: .topBarTrailing){
                    Button(action:{
                        showingAddForm = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddForm){//sliding screen
                AddRecordView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for:DailyRecord.self)
}
