import puppeteer from 'puppeteer';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import MarkdownIt from 'markdown-it';

const md = new MarkdownIt();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Academic/Business styling
const academicStyle = `
@import url('https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&display=swap');

body {
    font-family: 'Merriweather', serif;
    line-height: 1.8;
    color: #333333;
    background: #ffffff;
    margin: 0;
    padding: 40px;
    max-width: 900px;
    margin: 0 auto;
}

h1, h2, h3, h4, h5, h6 {
    color: #1a1a1a;
    font-weight: 700;
    margin-top: 2em;
    margin-bottom: 1em;
    page-break-after: avoid;
}

h1 {
    font-size: 2.2em;
    text-align: left;
    margin-bottom: 1.5em;
    border-bottom: 2px solid #1a1a1a;
    padding-bottom: 0.3em;
}

h2 {
    font-size: 1.8em;
    color: #2c5282;
    margin-top: 2em;
}

p {
    margin: 1.5em 0;
    text-align: justify;
}

ul, ol {
    margin: 1.5em 0;
    padding-left: 2em;
}

li {
    margin-bottom: 0.5em;
    line-height: 1.6;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 2em 0;
}

th, td {
    border: 1px solid #e2e8f0;
    padding: 12px;
    text-align: left;
}

th {
    background-color: #f8f9fa;
    color: #2d3748;
    font-weight: 600;
}

.cover {
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 4em;
}

.cover h1 {
    font-size: 2.5em;
    margin-bottom: 1em;
    color: #2c5282;
    border-bottom: none;
    text-align: center;
}

.cover .subtitle {
    font-size: 1.5em;
    color: #4a5568;
    margin-bottom: 2em;
    max-width: 600px;
    line-height: 1.6;
}

.cover .author {
    font-size: 1.2em;
    color: #718096;
    margin-top: 2em;
    font-style: italic;
}

.executive-summary {
    background: #f8f9fa;
    padding: 2em;
    margin: 2em 0;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
}

.references {
    margin-top: 3em;
    border-top: 2px solid #e2e8f0;
    padding-top: 2em;
}

.reference-item {
    margin-bottom: 1em;
    padding-left: 2em;
    text-indent: -2em;
    font-size: 0.95em;
}

.page-number {
    position: fixed;
    bottom: 30px;
    right: 30px;
    font-size: 0.9em;
    color: #718096;
}
`;

// Report templates
const reports = [
    {
        title: "Full Academic Report",
        filename: "Full_Academic_Report.pdf",
        content: `
# The $19 Trillion Solution: A Comprehensive Economic Analysis

## Executive Summary

This report presents a detailed analysis of Australia's $19.3 trillion in national assets and proposes a transformative economic framework for utilizing this wealth to eliminate poverty, abolish public debt, and establish universal prosperity.

## 1. Introduction

Australia's National Balance Sheet reveals an extraordinary level of national wealth that has remained largely untapped for public benefit. This report examines the potential of mobilizing these assets through innovative financial mechanisms.

## 2. Methodology

Our analysis employs a mixed-methods approach combining:
- Quantitative analysis of national accounts
- Economic modeling of wealth distribution impacts
- Comparative analysis of international case studies
- Stakeholder consultation and feedback integration

## 3. Key Findings

### 3.1 Asset Analysis
- Total national assets: $19.3 trillion
- Per capita allocation potential: $104,000
- Annual distribution capacity: $800 weekly per person
- Government operations funding: 5+ years

### 3.2 Economic Impact
- Immediate poverty elimination
- Complete public debt resolution
- Universal basic income implementation
- Economic growth acceleration

## 4. Implementation Framework

### 4.1 Sovereign Wealth Conversion
- Asset digitization process
- Regulatory framework
- Risk management protocols

### 4.2 Distribution Mechanism
- Digital civic shares allocation
- Weekly payment infrastructure
- Monitoring and adjustment systems

## 5. Risk Assessment

### 5.1 Economic Risks
- Inflation management
- Market stability measures
- Currency value protection

### 5.2 Implementation Risks
- Technical infrastructure requirements
- Legal framework adaptation
- Public communication strategy

## 6. Recommendations

1. Immediate legislative framework development
2. Phased implementation approach
3. Robust monitoring system establishment
4. Public engagement campaign

## 7. Conclusion

The $19 trillion solution represents a viable and transformative approach to achieving universal prosperity in Australia, supported by existing assets and implementable through current systems.

## References

1. Australian Bureau of Statistics. (2024). National Accounts
2. Reserve Bank of Australia. (2024). Economic Analysis
3. World Bank. (2024). Comparative Economic Studies
4. International Monetary Fund. (2024). Australia Economic Review
`
    },
    {
        title: "Implementation Guide",
        filename: "Topic_Implementation.pdf",
        content: `
# Implementation Guide: The $19 Trillion Solution

## Overview

This guide provides a detailed roadmap for implementing the $19 trillion economic transformation program, focusing on practical steps, technical requirements, and success metrics.

## Implementation Timeline

### Phase 1: Preparation (Months 1-3)
- Legislative framework development
- Technical infrastructure setup
- Stakeholder engagement initiation

### Phase 2: Initial Deployment (Months 4-6)
- System testing and validation
- Pilot program launch
- Feedback collection and integration

### Phase 3: Full Implementation (Months 7-12)
- National rollout
- Monitoring and adjustment
- Impact assessment

## Technical Requirements

### Digital Infrastructure
- Asset tracking system
- Distribution platform
- Security protocols
- Monitoring tools

### Operational Framework
- Governance structure
- Risk management
- Compliance monitoring
- Performance metrics

## Success Metrics

### Key Performance Indicators
1. Distribution efficiency
2. Economic impact measures
3. System stability metrics
4. Public engagement levels

### Monitoring Framework
- Real-time tracking
- Regular reporting
- Public dashboard
- Feedback mechanisms

## Risk Management

### Risk Categories
1. Technical risks
2. Economic risks
3. Social risks
4. Political risks

### Mitigation Strategies
- Robust testing
- Phased implementation
- Public communication
- Stakeholder engagement

## Conclusion

This implementation guide provides a structured approach to realizing the $19 trillion solution, ensuring efficient and effective deployment while managing potential risks and challenges.
`
    },
    {
        title: "One Page Summary",
        filename: "One_Page_Summary.pdf",
        content: `
# The $19 Trillion Solution: Executive Summary

## Overview

Australia possesses $19.3 trillion in national assets that can be mobilized to eliminate poverty, abolish public debt, and provide universal prosperity for all citizens through an innovative economic transformation program.

## Key Components

1. **Asset Utilization**
   - Total Assets: $19.3 trillion
   - Per Capita: $104,000
   - Weekly Distribution: $800
   - Government Funding: 5+ years

2. **Implementation Framework**
   - Digital asset conversion
   - Universal distribution system
   - Automated payment infrastructure
   - Real-time monitoring

3. **Expected Outcomes**
   - Poverty elimination
   - Debt abolishment
   - Economic growth
   - Social stability

## Implementation Timeline

- **Preparation**: 3 months
- **Initial Deployment**: 3 months
- **Full Implementation**: 6 months
- **Total Duration**: 12 months

## Contact

For more information:
Email: info@tiation.org
Website: https://tiation.org
`
    }
];

// Topic-specific report templates
const topicReports = [
    {
        title: "Introduction & Overview",
        filename: "Topic_1.pdf",
        content: `# Introduction to the $19 Trillion Solution

## Overview

This report introduces the foundational concepts and principles behind Australia's $19 trillion economic transformation initiative.

## Key Concepts

1. Asset Utilization
2. Wealth Distribution
3. Economic Transformation
4. Social Impact

## Background

Australia's national balance sheet reveals extraordinary untapped potential for creating universal prosperity...`
    },
    {
        title: "Current Economic State",
        filename: "Topic_2.pdf",
        content: `# Current Economic State Analysis

## Overview

A comprehensive analysis of Australia's current economic landscape and the potential for transformation.

## Economic Indicators

1. GDP Growth
2. Wealth Distribution
3. Asset Allocation
4. Public Debt

## Challenges

Current economic challenges and their impact on society...`
    },
    // Add more topic reports here
];

// Generate HTML for a report
const generateReportHtml = (report) => `
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>${academicStyle}</style>
</head>
<body>
    <div class="cover">
        <h1>${report.title}</h1>
        <div class="subtitle">Part of the $19 Trillion Solution Research Series</div>
        <div class="author">Tiation Research Institute</div>
    </div>
    ${md.render(report.content)}
</body>
</html>
`;

// Generate PDF from HTML
async function generatePdf(html, outputPath) {
    const browser = await puppeteer.launch({
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    const page = await browser.newPage();
    
    // Write HTML to temporary file
    const tempHtmlPath = path.join(__dirname, 'temp.html');
    fs.writeFileSync(tempHtmlPath, html);
    
    await page.goto(`file://${tempHtmlPath}`, { waitUntil: 'networkidle0' });
    
    await page.pdf({
        path: outputPath,
        format: 'A4',
        margin: { top: '1cm', right: '1cm', bottom: '1cm', left: '1cm' },
        printBackground: true
    });
    
    await browser.close();
    fs.unlinkSync(tempHtmlPath);
}

// Generate all reports
async function generateAllReports() {
    const publicDir = path.join(__dirname, '../public');
    
    // Generate main reports
    for (const report of reports) {
        console.log(`Generating ${report.filename}...`);
        const html = generateReportHtml(report);
        await generatePdf(html, path.join(publicDir, report.filename));
    }
    
    // Generate topic reports
    for (const topic of topicReports) {
        console.log(`Generating ${topic.filename}...`);
        const html = generateReportHtml(topic);
        await generatePdf(html, path.join(publicDir, topic.filename));
    }
    
    console.log('All reports generated successfully!');
}

// Run the generation
generateAllReports().catch(console.error);
