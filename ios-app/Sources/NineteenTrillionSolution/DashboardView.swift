//
//  DashboardView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var dataController: DataController
    @State private var animateChart = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Hero Card
                    HeroCard()
                    
                    // Key Metrics
                    MetricsGrid()
                    
                    // Asset Allocation Chart
                    AssetAllocationChart(animate: animateChart)
                    
                    // Impact Cards
                    ImpactSection()
                }
                .padding()
            }
            .navigationTitle("19 Trillion Solution")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    animateChart = true
                }
            }
        }
    }
}

struct HeroCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Unlocking Australia's Wealth")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Transform $19 trillion in national assets into prosperity for every Australian")
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Evidence-based economic reform")
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
    }
}

struct MetricsGrid: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            MetricCard(
                title: "Total Assets",
                value: formatCurrency(dataController.totalAssets),
                icon: "dollarsign.circle.fill",
                color: .blue
            )
            
            MetricCard(
                title: "Unlocked Value",
                value: formatCurrency(dataController.unlockedValue),
                icon: "lock.open.fill",
                color: .green
            )
            
            MetricCard(
                title: "Debt Elimination",
                value: formatCurrency(dataController.debtToEliminate),
                icon: "minus.circle.fill",
                color: .red
            )
            
            MetricCard(
                title: "UBI per Person",
                value: formatCurrency(dataController.actualUBIPerPerson),
                icon: "person.2.fill",
                color: .purple
            )
        }
    }
    
    func formatCurrency(_ value: Double) -> String {
        if value >= 1_000_000_000_000 {
            return String(format: "$%.1fT", value / 1_000_000_000_000)
        } else if value >= 1_000_000_000 {
            return String(format: "$%.1fB", value / 1_000_000_000)
        } else if value >= 1_000_000 {
            return String(format: "$%.1fM", value / 1_000_000)
        } else if value >= 1_000 {
            return String(format: "$%.0fK", value / 1_000)
        } else {
            return String(format: "$%.0f", value)
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                Spacer()
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct AssetAllocationChart: View {
    @EnvironmentObject var dataController: DataController
    let animate: Bool
    
    var chartData: [(String, Double, Color)] {
        [
            ("Debt Elimination", dataController.debtToEliminate, .red),
            ("Gov Funding", dataController.governmentFunding, .orange),
            ("UBI Fund", dataController.totalUBIFund, .green),
            ("Reserved Assets", dataController.totalAssets - dataController.unlockedValue, .gray)
        ]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Asset Allocation")
                .font(.headline)
            
            Chart(chartData, id: \.0) { item in
                SectorMark(
                    angle: .value("Value", animate ? item.1 : 0),
                    innerRadius: .ratio(0.6)
                )
                .foregroundStyle(item.2)
            }
            .frame(height: 200)
            
            // Legend
            VStack(alignment: .leading, spacing: 8) {
                ForEach(chartData, id: \.0) { item in
                    HStack {
                        Circle()
                            .fill(item.2)
                            .frame(width: 12, height: 12)
                        Text(item.0)
                            .font(.caption)
                        Spacer()
                        Text(formatValue(item.1))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    func formatValue(_ value: Double) -> String {
        if value >= 1_000_000_000_000 {
            return String(format: "$%.1fT", value / 1_000_000_000_000)
        } else {
            return String(format: "$%.1fB", value / 1_000_000_000)
        }
    }
}

struct ImpactSection: View {
    var impacts = [
        ("Economic Freedom", "Every Australian receives asset-backed income", "banknote"),
        ("Debt-Free Nation", "All public debt eliminated immediately", "xmark.circle"),
        ("Sustainable Future", "5+ years of pre-funded government operations", "leaf.fill"),
        ("Innovation Boost", "Capital for new ventures and growth", "lightbulb.fill")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Key Impacts")
                .font(.headline)
            
            ForEach(impacts, id: \.0) { impact in
                HStack(spacing: 16) {
                    Image(systemName: impact.2)
                        .font(.title2)
                        .foregroundColor(.blue)
                        .frame(width: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(impact.0)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(impact.1)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DataController())
    }
}
