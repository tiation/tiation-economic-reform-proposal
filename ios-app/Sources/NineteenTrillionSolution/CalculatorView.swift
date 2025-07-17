//
//  CalculatorView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var dataController: DataController
    @State private var unlockPercentage: Double = 33.0
    @State private var householdSize: Double = 2.5
    @State private var selectedState = "NSW"
    
    let australianStates = ["NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Unlock Percentage Slider
                    UnlockPercentageCard(percentage: $unlockPercentage)
                    
                    // Personal Impact Calculator
                    PersonalImpactCard(householdSize: $householdSize, selectedState: $selectedState)
                    
                    // Results
                    CalculationResults(
                        unlockPercentage: unlockPercentage,
                        householdSize: householdSize
                    )
                    
                    // Comparison Chart
                    ComparisonChart()
                }
                .padding()
            }
            .navigationTitle("Impact Calculator")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct UnlockPercentageCard: View {
    @Binding var percentage: Double
    @EnvironmentObject var dataController: DataController
    
    var unlockedAmount: Double {
        dataController.totalAssets * (percentage / 100)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Asset Unlock Percentage")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(Int(percentage))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Text(formatCurrency(unlockedAmount))
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                Slider(value: $percentage, in: 10...50, step: 1)
                    .accentColor(.blue)
                
                HStack {
                    Text("Conservative")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("Aggressive")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Text("Adjusting the unlock percentage affects the total funds available for debt elimination, government funding, and UBI.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    func formatCurrency(_ value: Double) -> String {
        String(format: "$%.1fT", value / 1_000_000_000_000)
    }
}

struct PersonalImpactCard: View {
    @Binding var householdSize: Double
    @Binding var selectedState: String
    let states = ["NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Household")
                .font(.headline)
            
            // Household Size
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Household Members")
                    Spacer()
                    Text("\(Int(householdSize))")
                        .fontWeight(.semibold)
                }
                
                Slider(value: $householdSize, in: 1...8, step: 1)
                    .accentColor(.blue)
            }
            
            // State Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("State/Territory")
                    .font(.subheadline)
                
                Picker("State", selection: $selectedState) {
                    ForEach(states, id: \.self) { state in
                        Text(state).tag(state)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct CalculationResults: View {
    let unlockPercentage: Double
    let householdSize: Double
    @EnvironmentObject var dataController: DataController
    
    var totalUnlocked: Double {
        dataController.totalAssets * (unlockPercentage / 100)
    }
    
    var remainingAfterDebtAndGov: Double {
        totalUnlocked - dataController.debtToEliminate - dataController.governmentFunding
    }
    
    var ubiPerPerson: Double {
        remainingAfterDebtAndGov / dataController.population
    }
    
    var householdUBI: Double {
        ubiPerPerson * householdSize
    }
    
    var monthlyUBI: Double {
        householdUBI / 12
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Your Estimated Impact")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Individual UBI
            ResultCard(
                title: "Annual UBI per Person",
                value: formatCurrency(ubiPerPerson),
                subtitle: "Tax-free income",
                icon: "person.fill",
                color: .green
            )
            
            // Household UBI
            ResultCard(
                title: "Your Household Total",
                value: formatCurrency(householdUBI),
                subtitle: "Annual household income",
                icon: "house.fill",
                color: .blue
            )
            
            // Monthly Income
            ResultCard(
                title: "Monthly Income",
                value: formatCurrency(monthlyUBI),
                subtitle: "Per month for your household",
                icon: "calendar",
                color: .purple
            )
        }
    }
    
    func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value)) ?? "$0"
    }
}

struct ResultCard: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct ComparisonChart: View {
    let comparisons = [
        ("Current Median Income", 67000.0),
        ("With UBI (Conservative)", 117000.0),
        ("With UBI (Optimal)", 142000.0),
        ("With UBI (Aggressive)", 167000.0)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Income Comparison")
                .font(.headline)
            
            VStack(spacing: 12) {
                ForEach(comparisons, id: \.0) { item in
                    HStack {
                        Text(item.0)
                            .font(.subheadline)
                            .frame(width: 150, alignment: .leading)
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 20)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(item.0 == "Current Median Income" ? Color.gray : Color.green)
                                    .frame(width: geometry.size.width * (item.1 / 200000.0), height: 20)
                            }
                        }
                        .frame(height: 20)
                        
                        Text(formatCurrency(item.1))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .frame(width: 70, alignment: .trailing)
                    }
                }
            }
            
            Text("Comparison shows household income potential with different unlock scenarios")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    func formatCurrency(_ value: Double) -> String {
        String(format: "$%.0fK", value / 1000)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(DataController())
    }
}
