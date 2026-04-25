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

    //AppStorage variables to read targets
    @AppStorage("waterTarget") var waterTarget: Int = 2000
    @AppStorage("calorieTarget") var calorieTarget: Int = 2000
    @State private var showingSettings: Bool = false
    
    @State private var showingAddForm = false
    @StateObject var hkManager = HealthKitManager()
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    NavigationLink(destination: ChartView()){
                        HStack{
                            Image(systemName:"chart.bar.fill")
                                .foregroundStyle(.blue)
                            Text("View Progress Charts")
                                .font(.headline)
                        }
                    }
                }
                Section("Today's Activity") {
                    HStack {
                        Image(systemName: "figure.walk")
                            .foregroundStyle(.green)
                        Text("Steps Taken:")
                        Spacer()
                        Text("\(hkManager.todaySteps, specifier: "%.0f")")
                            .bold()
                    }
                }
                ForEach(records){ record in //looped thru every saved day
                    VStack(alignment: .leading){
                        Text(record.date, format: .dateTime.month().day())
                            .font(.headline)
                        //coloured pgrogression
                        Text("Water: \(record.waterConsumed) / \(waterTarget) mL")
                            .foregroundStyle(record.waterConsumed >= waterTarget ? .green: .secondary)
                        
                        Text("Food: \(record.caloriesConsumed) / \(calorieTarget) kcal")
                            .foregroundStyle(record.caloriesConsumed >= calorieTarget ? .green: .secondary)
                    }
                }
                //delete operation
                .onDelete(perform: deleteRecord)
            }
            
            .navigationTitle("History")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    HStack{
                        Button(action:{
                            showingSettings = true
                        }){
                            Image(systemName:"gear")
                        }
                            
                        Button(action:{
                            showingAddForm = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showingAddForm){//sliding screen
                AddRecordView()
                
            }
            .sheet(isPresented:$showingSettings){
                SettingsView()
                
            }
            //trigger healthKit permission
            .onAppear {
                hkManager.requestAuthorization()
                
            }
        }
    }
    //the swipe to delete action
        func deleteRecord(offsets: IndexSet) {
            for index in offsets {
                //find the exact record the user swiped on and delete it
                let recordToDelete = records[index]
                modelContext.delete(recordToDelete)
            }
            //save the database after deleting
            try? modelContext.save()
        }
}

#Preview {
    ContentView()
        .modelContainer(for:DailyRecord.self)
}
