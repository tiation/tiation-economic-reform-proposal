//
//  TimelineView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI

struct TimelineView: View {
    @State private var selectedPhase = 0
    
    let phases = [
        TimelinePhase(
            id: 0,
            title: "Phase 1: Asset Audit",
            duration: "Months 1-3",
            description: "Comprehensive audit of Australia's $19 trillion in national assets",
            tasks: [
                "Establish independent audit commission",
                "Catalog all government assets",
                "Verify valuations with international standards",
                "Create transparent asset registry"
            ],
            status: .upcoming
        ),
        TimelinePhase(
            id: 1,
            title: "Phase 2: Legal Framework",
            duration: "Months 4-6",
            description: "Establish legal and regulatory framework for asset monetization",
            tasks: [
                "Draft enabling legislation",
                "Create oversight mechanisms",
                "Establish citizen dividend trust",
                "Set up distribution infrastructure"
            ],
            status: .upcoming
        ),
        TimelinePhase(
            id: 2,
            title: "Phase 3: Debt Elimination",
            duration: "Months 7-9",
            description: "Systematic elimination of all public debt",
            tasks: [
                "Retire federal government debt",
                "Clear state and territory obligations",
                "Eliminate local government liabilities",
                "Verify debt-free status"
            ],
            status: .upcoming
        ),
        TimelinePhase(
            id: 3,
            title: "Phase 4: Government Pre-funding",
            duration: "Months 10-12",
            description: "Pre-fund government operations for 5+ years",
            tasks: [
                "Calculate operational requirements",
                "Establish reserve funds",
                "Create investment protocols",
                "Implement transparency measures"
            ],
            status: .upcoming
        ),
        TimelinePhase(
            id: 4,
            title: "Phase 5: UBI Launch",
            duration: "Year 2+",
            description: "Launch Universal Basic Income for all Australians",
            tasks: [
                "Register all citizens",
                "Test distribution systems",
                "Begin phased rollout",
                "Monitor economic impacts"
            ],
            status: .upcoming
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Timeline Overview
                    TimelineOverview()
                    
                    // Phase Selector
                    PhaseSelector(selectedPhase: $selectedPhase, phases: phases)
                    
                    // Phase Details
                    if selectedPhase < phases.count {
                        PhaseDetailCard(phase: phases[selectedPhase])
                    }
                    
                    // Implementation Progress
                    ImplementationProgress()
                }
                .padding()
            }
            .navigationTitle("Implementation Timeline")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct TimelineOverview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("From Proposal to Prosperity")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("A clear, transparent roadmap to transform Australia's economy through systematic implementation of the $19 trillion solution.")
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack(spacing: 16) {
                InfoBadge(icon: "calendar", text: "24 months", color: .blue)
                InfoBadge(icon: "checkmark.shield", text: "5 phases", color: .green)
                InfoBadge(icon: "person.3", text: "26M beneficiaries", color: .purple)
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

struct InfoBadge: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

struct PhaseSelector: View {
    @Binding var selectedPhase: Int
    let phases: [TimelinePhase]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(phases) { phase in
                    PhaseButton(
                        phase: phase,
                        isSelected: selectedPhase == phase.id,
                        action: { selectedPhase = phase.id }
                    )
                }
            }
        }
    }
}

struct PhaseButton: View {
    let phase: TimelinePhase
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text("Phase \(phase.id + 1)")
                    .font(.caption)
                    .fontWeight(.semibold)
                Text(phase.duration)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.blue : Color(.systemGray5))
            )
            .foregroundColor(isSelected ? .white : .primary)
        }
    }
}

struct PhaseDetailCard: View {
    let phase: TimelinePhase
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(phase.title)
                        .font(.headline)
                    Text(phase.duration)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                StatusBadge(status: phase.status)
            }
            
            // Description
            Text(phase.description)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            
            // Tasks
            VStack(alignment: .leading, spacing: 8) {
                Text("Key Tasks")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                ForEach(phase.tasks, id: \.self) { task in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(.blue)
                            .padding(.top, 6)
                        Text(task)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct StatusBadge: View {
    let status: PhaseStatus
    
    var statusColor: Color {
        switch status {
        case .completed: return .green
        case .inProgress: return .orange
        case .upcoming: return .blue
        }
    }
    
    var statusText: String {
        switch status {
        case .completed: return "Completed"
        case .inProgress: return "In Progress"
        case .upcoming: return "Upcoming"
        }
    }
    
    var body: some View {
        Text(statusText)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(statusColor.opacity(0.2))
            .foregroundColor(statusColor)
            .cornerRadius(12)
    }
}

struct ImplementationProgress: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Overall Progress")
                .font(.headline)
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .frame(height: 12)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [Color.blue, Color.blue.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * 0.15, height: 12)
                }
            }
            .frame(height: 12)
            
            // Milestones
            VStack(alignment: .leading, spacing: 12) {
                MilestoneRow(
                    title: "Political Consensus",
                    description: "Building cross-party support",
                    progress: 0.3
                )
                MilestoneRow(
                    title: "Public Awareness",
                    description: "Education and engagement campaign",
                    progress: 0.4
                )
                MilestoneRow(
                    title: "Technical Preparation",
                    description: "Systems and infrastructure",
                    progress: 0.2
                )
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct MilestoneRow: View {
    let title: String
    let description: String
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(.systemGray5))
                        .frame(height: 4)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.green)
                        .frame(width: geometry.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
        }
    }
}

// Data Models
struct TimelinePhase: Identifiable {
    let id: Int
    let title: String
    let duration: String
    let description: String
    let tasks: [String]
    let status: PhaseStatus
}

enum PhaseStatus {
    case completed
    case inProgress
    case upcoming
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
