//
//  NineteenTrillionSolutionApp.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI

@main
struct NineteenTrillionSolutionApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dataController)
                .preferredColorScheme(.light)
        }
    }
}

// Data Controller for managing app state
class DataController: ObservableObject {
    @Published var totalAssets: Double = 19_000_000_000_000 // $19 trillion
    @Published var debtToEliminate: Double = 1_200_000_000_000 // $1.2 trillion
    @Published var governmentFunding: Double = 2_500_000_000_000 // $2.5 trillion
    @Published var ubiPerPerson: Double = 50_000 // $50k per person
    @Published var population: Double = 26_000_000 // 26 million Australians
    
    var unlockedValue: Double {
        totalAssets * 0.33 // Unlocking 1/3 of total assets
    }
    
    var remainingAfterDebt: Double {
        unlockedValue - debtToEliminate
    }
    
    var remainingAfterGovFunding: Double {
        remainingAfterDebt - governmentFunding
    }
    
    var totalUBIFund: Double {
        remainingAfterGovFunding
    }
    
    var actualUBIPerPerson: Double {
        totalUBIFund / population
    }
}
