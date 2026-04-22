//
//  ChartView.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 21/04/2026.
//

import SwiftUI
import SwiftData
import Charts

struct ChartView: View {
    //fetch from database
    @Query(sort:\DailyRecord.date) var records: [DailyRecord]
    var body: some View {
        VStack{
            Text("Calorie Intake History")
                .font(.headline)
                .padding(.top)
            
            Chart{
                ForEach(records){record in
                //do bars
                    BarMark(
                        x: .value("Date", record.date, unit: .day),
                        y: .value("Calories", record.caloriesConsumed)
                        )
                    .foregroundStyle(.blue)
                }
                
            }
            .frame(height:250)
            .padding()
            
            Spacer()
        }
        .navigationTitle("Activity Charts")
        .navigationBarTitleDisplayMode( .inline )
    }
}

#Preview {
    ChartView()
        .modelContainer(for: DailyRecord.self)
}
