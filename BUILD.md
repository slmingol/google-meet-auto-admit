# Build and Release Instructions

## Automatic Building

This repository uses GitHub Actions to automatically build the extension ZIP file on every push to `main`.

### Artifacts

After each push, you can download the built extension:

1. Go to the [Actions tab](../../actions)
2. Click on the latest workflow run
3. Download the artifact under "Artifacts"

The artifact includes:
- `google-meet-auto-admit-vX.X.X.zip` - The extension package
- `google-meet-auto-admit-vX.X.X.zip.sha256` - SHA256 checksum

## Creating a Release

To create a GitHub Release with the extension ZIP:

1. **Bump the version**:
   ```bash
   npm run version:patch  # or version:minor, version:major
   ```

2. **Commit and push**:
   ```bash
   git add -A
   git commit -m "Release v1.0.X"
   git push
   ```

3. **Create a git tag**:
   ```bash
   git tag v1.0.X
   git push origin v1.0.X
   ```

The GitHub Action will automatically:
- Build the extension ZIP
- Create a GitHub Release
- Attach the ZIP file and checksum
- Generate release notes

## Manual Build

If you need to build locally:

```bash
# Create package directory
mkdir -p extension-package

# Copy extension files
cp manifest.json content.js popup.html popup.js icon*.png extension-package/

# Create ZIP
cd extension-package
zip -r ../google-meet-auto-admit.zip .
cd ..

# Clean up
rm -rf extension-package
```

## What Gets Included

The CI/CD pipeline only includes essential extension files:
- `manifest.json` - Extension configuration
- `content.js` - Main extension logic
- `popup.html` - Popup interface
- `popup.js` - Popup logic
- `icon16.png`, `icon48.png`, `icon128.png` - Icons

### What Gets Excluded

Development and documentation files are excluded:
- Version control (`.git/`, `.gitignore`)
- Documentation (`README.md`, `PRIVACY.md`, etc.)
- Development scripts (`generate-icons.sh`, etc.)
- Source files (`source-icon.png`, backup files)
- Node modules (`node_modules/`, `package.json`)
- Build scripts
- GitHub workflows

## Uploading to Chrome Web Store

1. Download the ZIP from GitHub Actions artifacts or Releases
2. Go to [Chrome Web Store Developer Dashboard](https://chrome.google.com/webstore/devconsole/)
3. Click your extension (or "New Item")
4. Upload the ZIP file
5. Update store listing if needed
6. Submit for review

## File Integrity

Each build includes a SHA256 checksum. Verify integrity:

```bash
# Download both the ZIP and .sha256 files, then:
sha256sum -c google-meet-auto-admit-vX.X.X.zip.sha256
```

Result should show: `OK`
