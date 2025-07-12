# The $19 Trillion Solution - Australia's Economic Potential Unlocked

🚀 **Live Site**: [abundantaussie.com](https://abundantaussie.com) (via GitHub Pages)

## Overview

This repository contains the static website for "The $19 Trillion Solution," exploring how Australia can unlock its economic potential through innovative fiscal policy solutions.

## GitHub Pages Deployment

This site is automatically deployed to GitHub Pages using GitHub Actions.

### Setup Instructions

1. **Repository Settings**:
   - Go to your GitHub repository → Settings → Pages
   - Set source to "GitHub Actions"
   - The workflow will automatically deploy when you push to the `main` branch

2. **Automatic Deployment**:
   - Every push to the `main` branch triggers the deployment workflow
   - The workflow copies all static files to the `gh-pages` branch
   - Your site will be available at `https://username.github.io/repository-name/`

3. **Custom Domain** (Optional):
   - Add a `CNAME` file to the root directory with your custom domain
   - Configure DNS settings with your domain provider

### Project Structure

```
.
├── index.html              # Main HTML file
├── assets/                  # Static assets (CSS, JS, images)
├── dist/                    # Built files
├── *.pdf                    # Academic documents
├── *.png                    # Images and diagrams
├── favicon.ico             # Site icon
├── robots.txt              # SEO crawler instructions
├── sitemap.xml             # SEO sitemap
├── .nojekyll               # Disable Jekyll processing
└── .github/workflows/      # GitHub Actions deployment workflow
```

### Features

- 📱 **Responsive Design**: Works on all devices
- 🔍 **SEO Optimized**: Meta tags, sitemap, and robots.txt
- 🚀 **Fast Loading**: Optimized static assets
- 📊 **Analytics Ready**: Structured data for search engines
- 🔄 **Auto-Deploy**: GitHub Actions workflow for seamless updates

### Development

To make changes:

1. Edit the files in the repository
2. Commit your changes to the `main` branch
3. Push to GitHub
4. The workflow will automatically deploy your changes

### Troubleshooting

- **Deployment fails**: Check the Actions tab in your GitHub repository
- **Site not updating**: Ensure you're pushing to the `main` branch
- **404 errors**: Verify your `index.html` is in the root directory

## Contact

For questions or contributions, please open an issue or contact the maintainers.

---

*This project aims to spark meaningful discussions about Australia's economic future and potential pathways to prosperity.*

