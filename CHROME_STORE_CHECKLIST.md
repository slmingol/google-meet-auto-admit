# Quick Chrome Web Store Update Checklist

## ✅ Completed

- [x] Fixed critical state synchronization bug
- [x] Updated button selectors for Google Meet 2026
- [x] Enhanced debugging and logging
- [x] Added troubleshooting documentation
- [x] Updated VERSION to 1.0.15
- [x] Updated manifest.json to 1.0.15
- [x] Updated package.json to 1.0.15
- [x] Committed all changes
- [x] Created git tag v1.0.15
- [x] Pushed to GitHub
- [x] GitHub Actions will create release package

## 🔄 Next Steps - Chrome Web Store Submission

### 1. Download Package (Option A - Recommended)
Wait ~2 minutes for GitHub Actions to complete, then:
- Go to: https://github.com/slmingol/google-meet-auto-admit/releases/tag/v1.0.15
- Download: `google-meet-auto-admit-v1.0.15.zip`

### 1. Build Package (Option B - Manual)
```bash
cd /Users/smingolelli/dev/projects/google-meet-auto-admit
mkdir -p extension-package
cp manifest.json content.js popup.html popup.js icon*.png extension-package/
cd extension-package && zip -r ../google-meet-auto-admit-v1.0.15.zip . && cd ..
```

### 2. Submit to Chrome Web Store
1. Go to: https://chrome.google.com/webstore/devconsole
2. Find "Auto Admit for Google Meet"
3. Click **"Package"** → **"Upload new package"**
4. Upload `google-meet-auto-admit-v1.0.15.zip`
5. Review the changes preview

### 3. Update "What's New" Section
Copy this into the Chrome Web Store submission:

```
Version 1.0.15 - Critical Bug Fix

🐛 Fixes:
• Fixed critical bug where extension always started enabled
• Extension now properly respects your on/off setting
• Improved state synchronization between popup and background

⚡ Improvements:
• Updated for Google Meet's latest interface
• Smarter button detection prevents duplicates
• Enhanced debugging tools and console logs

This update is recommended for all users.
```

### 4. Add Submission Notes
```
Critical bug fix release for state synchronization issue.
Fixes extension ignoring user's saved on/off preference.
Updated selectors for Google Meet 2026 UI.
No new permissions. No data collection.
Backwards compatible.
```

### 5. Submit for Review
- Click **"Submit for review"**
- Typical review time: 1-3 business days

### 6. After Publication
- [ ] Verify version shows 1.0.15 on store page
- [ ] Test fresh installation
- [ ] Monitor reviews for feedback
- [ ] Check GitHub issues

---

## 📋 Key Files

- `/docs/CHROME_STORE_SUBMISSION.md` - Complete submission guide
- `/docs/STORE_LISTING.md` - Store listing copy
- `/docs/TROUBLESHOOTING.md` - User troubleshooting guide
- `/CHANGELOG.md` - Version history

## 🔗 Important Links

- **GitHub Release**: https://github.com/slmingol/google-meet-auto-admit/releases/tag/v1.0.15
- **Chrome Web Store Dashboard**: https://chrome.google.com/webstore/devconsole
- **Developer Docs**: https://developer.chrome.com/docs/webstore/

## 📞 Need Help?

See `/docs/CHROME_STORE_SUBMISSION.md` for detailed instructions and troubleshooting.
