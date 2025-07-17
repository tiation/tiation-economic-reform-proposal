//
//  ResourcesView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI

struct ResourcesView: View {
    @State private var selectedCategory = 0
    
    let categories = ["Documents", "Videos", "FAQ", "Research"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Category Picker
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(0..<categories.count, id: \.self) { index in
                            Text(categories[index]).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Content based on selection
                    switch selectedCategory {
                    case 0:
                        DocumentsSection()
                    case 1:
                        VideosSection()
                    case 2:
                        FAQSection()
                    case 3:
                        ResearchSection()
                    default:
                        EmptyView()
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Resources")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct DocumentsSection: View {
    let documents = [
        Document(
            title: "Executive Summary",
            description: "High-level overview of the $19 trillion solution",
            icon: "doc.text.fill",
            size: "2.4 MB",
            url: "https://tiation.github.io/19-trillion-solution/docs/executive-summary.pdf"
        ),
        Document(
            title: "Full Proposal",
            description: "Comprehensive 120-page policy document",
            icon: "doc.richtext.fill",
            size: "8.7 MB",
            url: "https://tiation.github.io/19-trillion-solution/docs/full-proposal.pdf"
        ),
        Document(
            title: "Economic Analysis",
            description: "Detailed financial modeling and projections",
            icon: "chart.line.uptrend.xyaxis",
            size: "4.3 MB",
            url: "https://tiation.github.io/19-trillion-solution/docs/economic-analysis.pdf"
        ),
        Document(
            title: "Implementation Guide",
            description: "Step-by-step implementation framework",
            icon: "checklist",
            size: "3.1 MB",
            url: "https://tiation.github.io/19-trillion-solution/docs/implementation.pdf"
        )
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(documents) { doc in
                DocumentCard(document: doc)
            }
        }
        .padding(.horizontal)
    }
}

struct DocumentCard: View {
    let document: Document
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: document.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(document.title)
                    .font(.headline)
                Text(document.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                HStack {
                    Text(document.size)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(action: {
                        // Open document
                    }) {
                        HStack(spacing: 4) {
                            Text("View")
                            Image(systemName: "arrow.down.circle")
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct VideosSection: View {
    let videos = [
        Video(
            title: "Solution Overview",
            duration: "12:45",
            thumbnail: "video.fill",
            description: "Introduction to the $19 trillion solution"
        ),
        Video(
            title: "Economic Impact",
            duration: "18:30",
            thumbnail: "chart.bar.fill",
            description: "How this transforms Australia's economy"
        ),
        Video(
            title: "Citizen Benefits",
            duration: "15:20",
            thumbnail: "person.3.fill",
            description: "What this means for every Australian"
        )
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(videos) { video in
                VideoCard(video: video)
            }
        }
        .padding(.horizontal)
    }
}

struct VideoCard: View {
    let video: Video
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 180)
                
                Image(systemName: video.thumbnail)
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                
                // Play button overlay
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            
            // Video info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(video.title)
                        .font(.headline)
                    Spacer()
                    Text(video.duration)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Text(video.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

struct FAQSection: View {
    @State private var expandedItems: Set<Int> = []
    
    let faqs = [
        FAQ(
            id: 0,
            question: "How can we be sure the $19 trillion valuation is accurate?",
            answer: "The valuation is based on official Australian government balance sheet data, verified by international accounting standards and independent audits. This includes land, infrastructure, natural resources, and other tangible assets."
        ),
        FAQ(
            id: 1,
            question: "Won't this cause inflation?",
            answer: "No, because we're not printing money. We're unlocking existing asset value. The funds are backed by real assets, similar to how a mortgage unlocks home value without creating inflation."
        ),
        FAQ(
            id: 2,
            question: "Is this socialism or communism?",
            answer: "Neither. This is asset-based capitalism that ensures every citizen benefits from national wealth. Private property and free markets remain intact - we're simply ensuring public assets benefit the public."
        ),
        FAQ(
            id: 3,
            question: "What happens after the UBI is distributed?",
            answer: "The UBI is sustainable because it's funded by returns on the remaining $13 trillion in assets. Government operations continue normally with pre-funded budgets, and the economy grows from increased consumer spending."
        ),
        FAQ(
            id: 4,
            question: "Has this been done anywhere else?",
            answer: "Similar models exist in Alaska (oil dividend) and Norway (sovereign wealth fund). Our approach is more comprehensive, leveraging all national assets rather than just natural resources."
        )
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(faqs) { faq in
                FAQItem(
                    faq: faq,
                    isExpanded: expandedItems.contains(faq.id),
                    toggle: {
                        withAnimation(.spring()) {
                            if expandedItems.contains(faq.id) {
                                expandedItems.remove(faq.id)
                            } else {
                                expandedItems.insert(faq.id)
                            }
                        }
                    }
                )
            }
        }
        .padding(.horizontal)
    }
}

struct FAQItem: View {
    let faq: FAQ
    let isExpanded: Bool
    let toggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: toggle) {
                HStack {
                    Text(faq.question)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            
            if isExpanded {
                Text(faq.answer)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct ResearchSection: View {
    let research = [
        Research(
            title: "Asset Valuation Methodology",
            author: "Prof. Sarah Chen, ANU",
            date: "March 2025",
            category: "Economics"
        ),
        Research(
            title: "Constitutional Law Analysis",
            author: "Justice Michael Roberts (ret.)",
            date: "February 2025",
            category: "Legal"
        ),
        Research(
            title: "Social Impact Assessment",
            author: "Dr. James Liu, UNSW",
            date: "April 2025",
            category: "Social Policy"
        ),
        Research(
            title: "International Comparisons",
            author: "Melbourne Institute",
            date: "January 2025",
            category: "Comparative"
        )
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(research) { item in
                ResearchCard(research: item)
            }
        }
        .padding(.horizontal)
    }
}

struct ResearchCard: View {
    let research: Research
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    CategoryBadge(category: research.category)
                    Spacer()
                    Text(research.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(research.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(research.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "arrow.right.circle")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct CategoryBadge: View {
    let category: String
    
    var color: Color {
        switch category {
        case "Economics": return .blue
        case "Legal": return .purple
        case "Social Policy": return .green
        case "Comparative": return .orange
        default: return .gray
        }
    }
    
    var body: some View {
        Text(category)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(6)
    }
}

// Data Models
struct Document: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let size: String
    let url: String
}

struct Video: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
    let thumbnail: String
    let description: String
}

struct FAQ: Identifiable {
    let id: Int
    let question: String
    let answer: String
}

struct Research: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let date: String
    let category: String
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}
