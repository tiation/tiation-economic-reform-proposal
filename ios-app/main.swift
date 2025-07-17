//
//  main.swift
//  19TrillionSolution
//
//  Simplified version for compilation
//

import SwiftUI

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

// Main App
@main
struct NineteenTrillionSolutionApp: App {
    let data = SolutionData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}

// Main Content View
struct ContentView: View {
    let data: SolutionData
    
    var body: some View {
        TabView {
            DashboardView(data: data)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.pie.fill")
                }
            
            CalculatorView(data: data)
                .tabItem {
                    Label("Calculator", systemImage: "plusminus.circle.fill")
                }
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle.fill")
                }
        }
    }
}

// Dashboard View
struct DashboardView: View {
    let data: SolutionData
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Hero Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Unlocking Australia's Wealth")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Transform $19 trillion in national assets into prosperity for every Australian")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Metrics
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        MetricCard(title: "Total Assets", value: "$19T", icon: "dollarsign.circle.fill", color: .blue)
                        MetricCard(title: "Unlocked Value", value: "$6.3T", icon: "lock.open.fill", color: .green)
                        MetricCard(title: "Debt Elimination", value: "$1.2T", icon: "minus.circle.fill", color: .red)
                        MetricCard(title: "UBI per Person", value: String(format: "$%.0fK", data.ubiPerPerson / 1000), icon: "person.2.fill", color: .purple)
                    }
                }
                .padding()
            }
            .navigationTitle("19 Trillion Solution")
        }
    }
}

// Calculator View
struct CalculatorView: View {
    let data: SolutionData
    @State private var householdSize: Double = 2.5
    
    var householdUBI: Double {
        data.ubiPerPerson * householdSize
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Household")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Household Members")
                            Spacer()
                            Text("\(Int(householdSize))")
                                .fontWeight(.semibold)
                        }
                        Slider(value: $householdSize, in: 1...8, step: 1)
                    }
                }
                
                Section(header: Text("Your Impact")) {
                    HStack {
                        Text("Annual UBI")
                        Spacer()
                        Text(String(format: "$%.0f", householdUBI))
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("Monthly Income")
                        Spacer()
                        Text(String(format: "$%.0f", householdUBI / 12))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Impact Calculator")
        }
    }
}

// About View
struct AboutView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("The $19 Trillion Solution")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("A partnership between Tiation and ChaseWhiteRabbit to transform Australia's wealth into prosperity for all citizens.")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        InfoRow(icon: "target", text: "Eliminate all public debt")
                        InfoRow(icon: "building.columns.fill", text: "Pre-fund government for 5+ years")
                        InfoRow(icon: "person.2.fill", text: "Provide UBI to all citizens")
                        InfoRow(icon: "leaf.fill", text: "Create sustainable growth")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("About")
        }
    }
}

// Helper Views
struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
        }
    }
}
