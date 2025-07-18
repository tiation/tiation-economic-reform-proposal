#!/usr/bin/env python3
"""
Repository Analysis Script for UX Enhancement Priority
Analyzes all repositories to identify which ones would benefit most from UX improvements
"""

import os
import json
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple, Optional

class RepositoryAnalyzer:
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.results = {}
        
    def has_github_pages(self, repo_path: Path) -> bool:
        """Check if repository has GitHub Pages enabled"""
        pages_indicators = [
            'index.html', 'index.md', '_config.yml', 
            'docs/index.html', 'docs/index.md'
        ]
        return any((repo_path / indicator).exists() for indicator in pages_indicators)
    
    def has_web_content(self, repo_path: Path) -> bool:
        """Check if repository contains web content"""
        web_files = list(repo_path.glob('**/*.html')) + list(repo_path.glob('**/*.css'))
        return len(web_files) > 0
    
    def count_documentation_files(self, repo_path: Path) -> int:
        """Count documentation files"""
        doc_files = list(repo_path.glob('**/*.md')) + list(repo_path.glob('**/*.rst'))
        return len(doc_files)
    
    def has_mobile_optimization(self, repo_path: Path) -> bool:
        """Check if repository has mobile optimization"""
        html_files = list(repo_path.glob('**/*.html'))
        for html_file in html_files:
            try:
                with open(html_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                    if 'viewport' in content and 'device-width' in content:
                        return True
            except:
                continue
        return False
    
    def get_repo_type(self, repo_name: str) -> str:
        """Categorize repository based on name patterns"""
        repo_lower = repo_name.lower()
        
        if any(keyword in repo_lower for keyword in ['docs', 'documentation', 'guide']):
            return 'Documentation'
        elif any(keyword in repo_lower for keyword in ['site', 'web', 'marketing', 'hub']):
            return 'Website'
        elif any(keyword in repo_lower for keyword in ['api', 'sdk', 'library']):
            return 'API/SDK'
        elif any(keyword in repo_lower for keyword in ['app', 'mobile', 'android']):
            return 'Application'
        elif any(keyword in repo_lower for keyword in ['template', 'theme']):
            return 'Template/Theme'
        elif any(keyword in repo_lower for keyword in ['infrastructure', 'server', 'config']):
            return 'Infrastructure'
        elif any(keyword in repo_lower for keyword in ['ai', 'machine-learning', 'ml']):
            return 'AI/ML'
        else:
            return 'Other'
    
    def get_priority_score(self, repo_data: Dict) -> int:
        """Calculate priority score for UX enhancement"""
        score = 0
        
        # High priority for public-facing content
        if repo_data['has_github_pages']:
            score += 50
        if repo_data['has_web_content']:
            score += 30
        if repo_data['doc_count'] > 5:
            score += 20
        
        # Bonus for specific types
        if repo_data['type'] in ['Website', 'Documentation']:
            score += 30
        elif repo_data['type'] in ['API/SDK', 'Template/Theme']:
            score += 20
        
        # Penalty for already optimized
        if repo_data['has_mobile_optimization']:
            score -= 10
        
        # Bonus for business-critical repos
        business_critical = ['economic-reform-proposal', 'ai-platform', 'rigger-workspace']
        if any(critical in repo_data['name'] for critical in business_critical):
            score += 25
        
        return max(0, score)
    
    def analyze_repository(self, repo_path: Path) -> Dict:
        """Analyze a single repository"""
        repo_name = repo_path.name
        
        if not repo_path.is_dir() or repo_name.startswith('.'):
            return None
        
        # Skip if it's a file, not a directory
        if not (repo_path / '.git').exists() and not any(repo_path.glob('*')):
            return None
        
        analysis = {
            'name': repo_name,
            'path': str(repo_path),
            'type': self.get_repo_type(repo_name),
            'has_github_pages': self.has_github_pages(repo_path),
            'has_web_content': self.has_web_content(repo_path),
            'doc_count': self.count_documentation_files(repo_path),
            'has_mobile_optimization': self.has_mobile_optimization(repo_path),
        }
        
        analysis['priority_score'] = self.get_priority_score(analysis)
        
        return analysis
    
    def analyze_all_repositories(self) -> List[Dict]:
        """Analyze all repositories in the base path"""
        results = []
        
        for item in self.base_path.iterdir():
            if item.is_dir() and not item.name.startswith('.'):
                analysis = self.analyze_repository(item)
                if analysis:
                    results.append(analysis)
        
        # Sort by priority score (descending)
        results.sort(key=lambda x: x['priority_score'], reverse=True)
        
        return results
    
    def generate_report(self, results: List[Dict]) -> str:
        """Generate a comprehensive report"""
        report = []
        report.append("# 🎯 Repository UX Enhancement Priority Analysis")
        report.append("## Executive Summary")
        report.append(f"- **Total Repositories Analyzed**: {len(results)}")
        report.append(f"- **High Priority (Score > 50)**: {len([r for r in results if r['priority_score'] > 50])}")
        report.append(f"- **Medium Priority (Score 25-50)**: {len([r for r in results if 25 <= r['priority_score'] <= 50])}")
        report.append(f"- **Low Priority (Score < 25)**: {len([r for r in results if r['priority_score'] < 25])}")
        report.append("")
        
        # Group by type
        by_type = {}
        for result in results:
            repo_type = result['type']
            if repo_type not in by_type:
                by_type[repo_type] = []
            by_type[repo_type].append(result)
        
        report.append("## Repository Types Distribution")
        for repo_type, repos in by_type.items():
            report.append(f"- **{repo_type}**: {len(repos)} repositories")
        report.append("")
        
        # Top priority repositories
        report.append("## 🚀 Top Priority Repositories (Score > 50)")
        high_priority = [r for r in results if r['priority_score'] > 50]
        
        if high_priority:
            report.append("| Repository | Type | Score | GitHub Pages | Web Content | Mobile Optimized |")
            report.append("|------------|------|-------|--------------|-------------|------------------|")
            for repo in high_priority:
                report.append(f"| **{repo['name']}** | {repo['type']} | {repo['priority_score']} | {'✅' if repo['has_github_pages'] else '❌'} | {'✅' if repo['has_web_content'] else '❌'} | {'✅' if repo['has_mobile_optimization'] else '❌'} |")
        else:
            report.append("No high-priority repositories found.")
        
        report.append("")
        
        # Medium priority repositories
        report.append("## 🔥 Medium Priority Repositories (Score 25-50)")
        medium_priority = [r for r in results if 25 <= r['priority_score'] <= 50]
        
        if medium_priority:
            report.append("| Repository | Type | Score | GitHub Pages | Web Content | Mobile Optimized |")
            report.append("|------------|------|-------|--------------|-------------|------------------|")
            for repo in medium_priority:
                report.append(f"| **{repo['name']}** | {repo['type']} | {repo['priority_score']} | {'✅' if repo['has_github_pages'] else '❌'} | {'✅' if repo['has_web_content'] else '❌'} | {'✅' if repo['has_mobile_optimization'] else '❌'} |")
        else:
            report.append("No medium-priority repositories found.")
        
        report.append("")
        
        # Recommendations
        report.append("## 📋 Recommendations")
        report.append("### Immediate Actions (High Priority)")
        for repo in high_priority[:5]:  # Top 5
            report.append(f"1. **{repo['name']}** - {repo['type']} repository")
            if not repo['has_mobile_optimization']:
                report.append("   - ⚠️ Needs mobile optimization")
            if repo['has_web_content'] and not repo['has_github_pages']:
                report.append("   - ⚠️ Has web content but no GitHub Pages")
            report.append("")
        
        report.append("### Next Phase (Medium Priority)")
        for repo in medium_priority[:3]:  # Top 3
            report.append(f"1. **{repo['name']}** - {repo['type']} repository")
            report.append(f"   - Priority Score: {repo['priority_score']}")
            report.append("")
        
        report.append("## 🛠️ Technical Implementation Plan")
        report.append("1. **Phase 1**: Focus on top 5 high-priority repositories")
        report.append("2. **Phase 2**: Address medium-priority website and documentation repositories")
        report.append("3. **Phase 3**: Implement design system across remaining repositories")
        report.append("")
        
        return "\n".join(report)

def main():
    # Analyze repositories
    analyzer = RepositoryAnalyzer('/Users/tiaastor/tiation-github')
    results = analyzer.analyze_all_repositories()
    
    # Generate report
    report = analyzer.generate_report(results)
    
    # Save results
    with open('/Users/tiaastor/tiation-github/tiation-economic-reform-proposal/UX_ENHANCEMENT_PRIORITY_REPORT.md', 'w') as f:
        f.write(report)
    
    # Save JSON data for further processing
    with open('/Users/tiaastor/tiation-github/tiation-economic-reform-proposal/repo_analysis_data.json', 'w') as f:
        json.dump(results, f, indent=2)
    
    print("✅ Analysis complete!")
    print(f"📊 Report saved to: UX_ENHANCEMENT_PRIORITY_REPORT.md")
    print(f"📋 Data saved to: repo_analysis_data.json")
    print(f"🎯 Found {len([r for r in results if r['priority_score'] > 50])} high-priority repositories")
    
    # Show top 5 priorities
    print("\n🚀 Top 5 Priority Repositories:")
    for i, repo in enumerate(results[:5], 1):
        print(f"{i}. {repo['name']} (Score: {repo['priority_score']}) - {repo['type']}")

if __name__ == "__main__":
    main()
