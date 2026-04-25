//
//  DailyRecord.swift
//  ConsumptionTracker
//
//  Created by Shahril S M B (FCES) on 20/04/2026.
//
import Foundation
import SwiftData//to use database features

@Model
class DailyRecord:Identifiable{
    private(set) var id = UUID()//variable setter private to get rid of warning
    var date : Date
    var waterConsumed : Int
    var caloriesConsumed : Int
    
    //daily record refreshing 
    init (date: Date = Date.now, waterConsumed: Int = 0, caloriesConsumed: Int = 0){
        self.date = date
        self.waterConsumed = waterConsumed
        self.caloriesConsumed = caloriesConsumed
    }
}
