//
//  AboutView.swift
//  19TrillionSolution
//
//  Created by Tia Astor on 07/16/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Section
                    AboutHeroSection()
                    
                    // Mission Statement
                    MissionSection()
                    
                    // Partner Organizations
                    PartnersSection()
                    
                    // Team Section
                    TeamSection()
                    
                    // Contact Section
                    ContactSection()
                    
                    // App Info
                    AppInfoSection()
                }
                .padding(.vertical)
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct AboutHeroSection: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "australiandollar.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("The $19 Trillion Solution")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Transforming Australia's wealth into prosperity for all")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                StatBadge(value: "$19T", label: "Total Assets")
                StatBadge(value: "26M", label: "Beneficiaries")
                StatBadge(value: "$50K+", label: "Per Person")
            }
        }
        .padding(.horizontal)
    }
}

struct StatBadge: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct MissionSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Our Mission")
                .font(.headline)
            
            Text("We believe Australia's vast national wealth should work for all Australians. Through evidence-based policy reform and transparent implementation, we're creating a future where every citizen benefits from our collective assets.")
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .leading, spacing: 12) {
                MissionPoint(
                    icon: "target",
                    text: "Eliminate all public debt immediately"
                )
                MissionPoint(
                    icon: "building.columns.fill",
                    text: "Pre-fund government for 5+ years"
                )
                MissionPoint(
                    icon: "person.2.fill",
                    text: "Provide asset-backed UBI to all citizens"
                )
                MissionPoint(
                    icon: "leaf.fill",
                    text: "Create sustainable economic growth"
                )
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct MissionPoint: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct PartnersSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Partner Organizations")
                .font(.headline)
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                PartnerCard(
                    name: "Tiation",
                    tagline: "Technology that serves humanity",
                    description: "Building enterprise-grade solutions that remove barriers and empower communities.",
                    website: "https://tiation.org"
                )
                
                PartnerCard(
                    name: "ChaseWhiteRabbit",
                    tagline: "Automation is compassion at scale",
                    description: "Transforming grief into systemic change through sustainable technology solutions.",
                    website: "https://chasewhiterabbit.org"
                )
            }
            .padding(.horizontal)
        }
    }
}

struct PartnerCard: View {
    let name: String
    let tagline: String
    let description: String
    let website: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                Text(tagline)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .italic()
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            Button(action: {
                // Open website
            }) {
                HStack {
                    Text("Visit Website")
                    Image(systemName: "arrow.up.right.square")
                }
                .font(.caption)
                .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

struct TeamSection: View {
    let team = [
        TeamMember(
            name: "Tia Astor",
            role: "Founder & Lead Developer",
            bio: "Passionate about using technology to create positive social change."
        ),
        TeamMember(
            name: "Economic Advisory Board",
            role: "Policy & Analysis",
            bio: "Leading economists and policy experts guiding implementation."
        ),
        TeamMember(
            name: "Community Contributors",
            role: "Open Source Development",
            bio: "Developers, designers, and advocates building the future together."
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Our Team")
                .font(.headline)
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                ForEach(team, id: \.name) { member in
                    TeamMemberCard(member: member)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TeamMember {
    let name: String
    let role: String
    let bio: String
}

struct TeamMemberCard: View {
    let member: TeamMember
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(member.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(member.role)
                    .font(.caption)
                    .foregroundColor(.blue)
                Text(member.bio)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
    }
}

struct ContactSection: View {
    let contacts = [
        ("envelope.fill", "General Inquiries", "info@tiation.org"),
        ("questionmark.circle.fill", "Support", "support@tiation.org"),
        ("shield.fill", "Security", "security@tiation.org"),
        ("newspaper.fill", "Media", "media@tiation.org")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Contact Us")
                .font(.headline)
            
            VStack(spacing: 12) {
                ForEach(contacts, id: \.1) { contact in
                    HStack(spacing: 16) {
                        Image(systemName: contact.0)
                            .font(.title3)
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(contact.1)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(contact.2)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "envelope")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Social Media
            HStack(spacing: 20) {
                SocialButton(icon: "link", label: "Website")
                SocialButton(icon: "message.fill", label: "Twitter")
                SocialButton(icon: "play.rectangle.fill", label: "YouTube")
                SocialButton(icon: "book.fill", label: "GitHub")
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct SocialButton: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct AppInfoSection: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("19 Trillion Solution")
                .font(.caption)
                .fontWeight(.semibold)
            Text("Version 1.0.0")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("© 2025 Tiation. All rights reserved.")
                .font(.caption2)
                .foregroundColor(.secondary)
            
            HStack(spacing: 16) {
                Button("Privacy Policy") {
                    // Open privacy policy
                }
                .font(.caption)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Button("Terms of Service") {
                    // Open terms
                }
                .font(.caption)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Button("Licenses") {
                    // Open licenses
                }
                .font(.caption)
            }
            .padding(.top, 4)
        }
        .padding()
        .padding(.horizontal)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
