import MarkdownIt from 'markdown-it';
import puppeteer from 'puppeteer';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const md = new MarkdownIt();

// Get current file's directory in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Custom CSS for the PDF - Academic/Business style
const customStyle = `
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

a {
    color: #2c5282;
    text-decoration: none;
    border-bottom: 1px solid #2c5282;
}

a:hover {
    text-decoration: underline;
    color: #00ffff;
}

blockquote {
    border-left: 4px solid #2c5282;
    margin: 2em 0;
    padding: 1em 2em;
    background: #f8f9fa;
    font-style: italic;
}

code {
    background: #f5f5f5;
    color: #2d3748;
    padding: 0.2em 0.4em;
    border-radius: 3px;
    font-family: 'Courier New', monospace;
}

pre {
    background: #2a2a2a;
    padding: 1em;
    border-radius: 5px;
    overflow-x: auto;
}

/* Cover page styling */
.cover {
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background: #ffffff;
    text-align: center;
    padding: 4em;
    border: 1px solid #e2e8f0;
    margin-bottom: 2em;
}

.cover h1 {
    font-size: 2.5em;
    margin-bottom: 1em;
    color: #2c5282;
    border-bottom: none;
    font-weight: 700;
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

/* Table of contents styling */
.toc {
    margin: 3em 0;
    padding: 2em;
    background: #f8f9fa;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
}

.toc h2 {
    color: #2c5282;
    border-bottom: none;
    font-size: 1.5em;
    margin-bottom: 1.5em;
}

.toc ul {
    list-style-type: none;
    padding-left: 0;
    margin-left: 0;
}

.toc a {
    color: #4a5568;
    text-decoration: none;
    line-height: 2;
    border-bottom: none;
}

/* Page numbers */
.page-number {
    position: absolute;
    bottom: 30px;
    right: 30px;
    color: #718096;
    font-size: 0.9em;
    font-family: 'Merriweather', serif;
}

/* Chapter title pages */
.chapter-title {
    page-break-before: always;
    text-align: left;
    padding: 4em 0 2em;
    border-bottom: 2px solid #2c5282;
}

/* Lists */
ul, ol {
    margin: 1.5em 0;
    padding-left: 2em;
}

li {
    margin-bottom: 0.5em;
    line-height: 1.6;
}

/* Tables */
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

/* Figures and Images */
figure {
    margin: 2em 0;
    text-align: center;
}

figure img {
    max-width: 100%;
    height: auto;
}

figcaption {
    color: #718096;
    font-size: 0.9em;
    margin-top: 1em;
    font-style: italic;
}

/* References */
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
`;

// Create cover page HTML
const coverHtml = `
<!DOCTYPE html>
<html>
<head>
    <style>${customStyle}</style>
</head>
<body>
    <div class="cover">
        <h1>Economic Reform Proposal</h1>
        <div class="subtitle">A Comprehensive Plan for Global Economic Transformation</div>
        <div class="author">By Tiation</div>
    </div>
</body>
</html>
`;

// Save cover HTML to a temporary file
fs.writeFileSync(path.join(__dirname, 'temp-cover.html'), coverHtml);

// Get all chapter files
const chaptersDir = path.join(__dirname, '../book/chapters');
const chapters = fs.readdirSync(chaptersDir)
    .filter(file => file.endsWith('.md'))
    .sort();

// Create table of contents
const tocContent = `# Table of Contents\n\n${
    chapters.map(chapter => {
        const title = fs.readFileSync(path.join(chaptersDir, chapter), 'utf8')
            .split('\n')[0]
            .replace('#', '')
            .trim();
        return `* [${title}](#${title.toLowerCase().replace(/\s+/g, '-')})`;
    }).join('\n')
}\n\n`;

// Combine all content
const allContent = [
    fs.readFileSync(path.join(__dirname, 'temp-cover.html'), 'utf8'),
    tocContent,
    ...chapters.map(chapter => fs.readFileSync(path.join(chaptersDir, chapter), 'utf8'))
].join('\n\n---\n\n');

// Convert markdown content to HTML
const markdownContent = chapters
    .map(chapter => fs.readFileSync(path.join(chaptersDir, chapter), 'utf8'))
    .join('\n\n---\n\n');

const htmlContent = `
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>${customStyle}</style>
</head>
<body>
    ${coverHtml}
    <div class="toc">
        ${md.render(tocContent)}
    </div>
    ${md.render(markdownContent)}
</body>
</html>
`;

// PDF generation options
const options = {
    format: 'A4',
    margin: { top: '1cm', right: '1cm', bottom: '1cm', left: '1cm' },
    printBackground: true
};

const file = { content: htmlContent };

// Create temporary HTML file
const tempHtmlPath = path.join(__dirname, 'temp.html');
fs.writeFileSync(tempHtmlPath, htmlContent);

// Generate PDF using Puppeteer
try {
    const browser = await puppeteer.launch({
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    const page = await browser.newPage();
    await page.goto(`file://${tempHtmlPath}`, { waitUntil: 'networkidle0' });
    
    const outputPath = path.join(__dirname, '../public/economic-reform-proposal.pdf');
    await page.pdf({
        path: outputPath,
        format: 'A4',
        printBackground: true,
        margin: { top: '1cm', right: '1cm', bottom: '1cm', left: '1cm' }
    });

    await browser.close();
    fs.unlinkSync(tempHtmlPath); // Clean up temporary file
    console.log('PDF generated successfully!');
} catch (error) {
    console.error('Error generating PDF:', error);
    if (fs.existsSync(tempHtmlPath)) {
        fs.unlinkSync(tempHtmlPath); // Clean up on error
    }
    process.exit(1);
}
