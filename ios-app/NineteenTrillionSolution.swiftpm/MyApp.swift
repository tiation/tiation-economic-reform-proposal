import SwiftUI

@main
struct MyApp: App {
    let data = SolutionData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}

// Simple data model
struct SolutionData {
    let totalAssets: Double = 19_000_000_000_000
    let debtToEliminate: Double = 1_200_000_000_000
    let governmentFunding: Double = 2_500_000_000_000
    let population: Double = 26_000_000
    
    var unlockedValue: Double {
        totalAssets * 0.33
    }
    
    var ubiPerPerson: Double {
        (unlockedValue - debtToEliminate - governmentFunding) / population
    }
}
