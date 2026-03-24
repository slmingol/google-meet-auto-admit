# Chrome Web Store Submission Guide

## Overview

This guide covers how to submit v1.0.15 to the Chrome Web Store.

## Prerequisites

1. **Chrome Web Store Developer Account** 
   - You need access to the Chrome Web Store Developer Dashboard
   - URL: https://chrome.google.com/webstore/devconsole

2. **Extension Package**
   - The GitHub Actions workflow automatically creates a ZIP package when you push a tag
   - Download it from: https://github.com/slmingol/google-meet-auto-admit/releases/tag/v1.0.15

## Step-by-Step Submission

### 1. Download the Package

Go to the GitHub release:
```
https://github.com/slmingol/google-meet-auto-admit/releases/tag/v1.0.15
```

Download: `google-meet-auto-admit-v1.0.15.zip`

**OR** create it locally:
```bash
cd /Users/smingolelli/dev/projects/google-meet-auto-admit

# Create package directory
mkdir -p extension-package

# Copy extension files
cp manifest.json extension-package/
cp content.js extension-package/
cp popup.html extension-package/
cp popup.js extension-package/
cp icon16.png extension-package/
cp icon48.png extension-package/
cp icon128.png extension-package/

# Create ZIP
cd extension-package
zip -r ../google-meet-auto-admit-v1.0.15.zip .
cd ..

echo "✓ Created google-meet-auto-admit-v1.0.15.zip"
```

### 2. Login to Chrome Web Store Developer Dashboard

1. Go to: https://chrome.google.com/webstore/devconsole
2. Sign in with your Google account that has developer access
3. Find "Auto Admit for Google Meet" in your items list

### 3. Upload New Version

1. Click on the extension name
2. Navigate to **"Package"** section
3. Click **"Upload new package"**
4. Select `google-meet-auto-admit-v1.0.15.zip`
5. Wait for upload to complete (Chrome will validate the package)

### 4. Update Store Listing (If Needed)

The store listing content is in `/docs/STORE_LISTING.md`. Review and update these sections if needed:

#### Version-Specific Changes for v1.0.15

**What's New in This Version** (add to description or "Recent changes"):
```
Version 1.0.15 brings critical bug fixes and improvements:

🐛 Fixes:
• Fixed critical bug where extension always started enabled, now properly respects your on/off setting
• Extension state now syncs correctly between popup and background

⚡ Improvements:
• Updated for Google Meet's 2026 interface
• Smarter button detection with duplicate prevention
• Better debugging tools and detailed console logs
• Enhanced troubleshooting documentation

This update is highly recommended for all users.
```

### 5. Update Screenshots (If UI Changed)

Current screenshots should show:
- Extension popup with toggle ON
- Extension popup with toggle OFF
- Console showing successful auto-admit logs
- Google Meet meeting with participants being auto-admitted

Location to upload: **Store Listing → Graphics** section

### 6. Review Privacy Practices

Confirm these answers in the **Privacy practices** section:

- **Single purpose**: Automatically admit participants to Google Meet calls
- **Data usage**: No user data is collected, used, or transmitted
- **Permissions justification**:
  - `activeTab`: Required to interact with Google Meet tabs
  - `storage`: Required to save user's on/off preference
  - `host_permissions (meet.google.com)`: Required to run on Google Meet pages only

### 7. Submit for Review

1. Review all changes in the preview
2. Click **"Submit for review"**
3. Add submission notes:
   ```
   Version 1.0.15 - Critical Bug Fix Release
   
   This update fixes a critical state synchronization bug where the extension
   would always start in the enabled state, ignoring the user's saved preference.
   
   Additionally, button selectors have been updated to work with Google Meet's
   current interface (2026), and improved debugging capabilities have been added.
   
   No new permissions requested. No changes to data collection (still none).
   All changes are backwards compatible.
   ```

### 8. Wait for Review

- **Typical review time**: 1-3 business days (sometimes faster)
- You'll receive an email when:
  - Review is complete
  - Extension is published
  - Any issues are found

### 9. Monitor After Publication

1. **Check extension page**: Verify version shows as 1.0.15
2. **Test auto-update**: The extension should auto-update for existing users within a few hours
3. **Monitor reviews**: Check for user feedback on the new version
4. **Watch GitHub issues**: Users may report issues there too

## Troubleshooting Submission Issues

### "Manifest version is not supported"
- Ensure `manifest_version: 3` (already correct in this extension)

### "Excessive permissions requested"
- We only request essential permissions (activeTab, storage, host_permissions)
- Justify them in the submission notes if flagged

### "Code obfuscation detected"
- This shouldn't happen (we don't obfuscate)
- If flagged, explain all code is readable vanilla JavaScript

### "Functionality issue"
- Provide test account if reviewer needs to test
- Include detailed testing instructions in submission notes

## Post-Publication Checklist

- [ ] Version 1.0.15 is live on Chrome Web Store
- [ ] Test installation from store
- [ ] Test auto-update from v1.0.14 to v1.0.15
- [ ] Update README.md with store link if needed
- [ ] Announce update (Twitter, blog, etc. if applicable)
- [ ] Monitor user reviews and GitHub issues

## Rollback Procedure (If Needed)

If critical issues are found after publication:

1. **Quick fix**: 
   - Unpublish the extension temporarily in Chrome Web Store
   - Fix the issue
   - Submit v1.0.16 immediately

2. **Revert**:
   - You cannot revert to previous version in Chrome Web Store
   - Must submit a new version with the fixes

## Support Resources

- **Chrome Web Store Developer Documentation**: https://developer.chrome.com/docs/webstore/
- **Chrome Extension Manifest V3**: https://developer.chrome.com/docs/extensions/mv3/
- **Extension Review Status**: Check developer dashboard for real-time status
- **Chrome Web Store Support**: https://support.google.com/chrome_webstore/

## Testing the Published Extension

After publication, test with a fresh profile:

```bash
# Open Chrome with a new profile
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=/tmp/chrome-test-profile

# Then:
# 1. Go to Chrome Web Store
# 2. Search for "Auto Admit for Google Meet"
# 3. Install from store
# 4. Test on a real Google Meet
```

---

**Version**: 1.0.15  
**Last Updated**: 2026-03-24
