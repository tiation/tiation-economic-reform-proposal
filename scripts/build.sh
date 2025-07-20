#!/bin/bash

# Make script executable
chmod +x scripts/generate-pdf.js

# Generate all reports
npm run generate-reports

# Build the site
npm run build

# Copy all PDFs to build directory
cp public/*.pdf dist/
cp public/*.pptx dist/ 2>/dev/null || true
