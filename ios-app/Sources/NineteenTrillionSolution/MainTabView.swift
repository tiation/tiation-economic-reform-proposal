//
//  MainTabView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.pie.fill")
                }
                .tag(0)
            
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "plusminus.circle.fill")
                }
                .tag(1)
            
            TimelineView()
                .tabItem {
                    Label("Timeline", systemImage: "calendar")
                }
                .tag(2)
            
            ResourcesView()
                .tabItem {
                    Label("Resources", systemImage: "doc.text.fill")
                }
                .tag(3)
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle.fill")
                }
                .tag(4)
        }
        .accentColor(.blue)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(DataController())
    }
}
