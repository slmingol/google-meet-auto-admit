# Usage Instructions - Auto Admit for Google Meet

## Installation

1. Visit the Chrome Web Store listing for "Auto Admit for Google Meet"
2. Click "Add to Chrome"
3. Click "Add extension" in the confirmation dialog
4. The extension icon will appear in your Chrome toolbar

## Getting Started

### First Time Setup

1. **Pin the extension** (optional but recommended)
   - Click the puzzle piece icon in Chrome toolbar
   - Find "Auto Admit for Google Meet"
   - Click the pin icon to keep it visible

2. **Verify it's enabled**
   - Click the extension icon
   - Ensure the toggle shows "Auto-admit is active" (green checkmark)

### Using the Extension

#### During a Google Meet

1. **Start or join a Google Meet** as the host or with admission permissions

2. **The extension works automatically**
   - When someone knocks to join, they'll be admitted instantly
   - No action needed from you

3. **Monitor activity** (optional)
   - Open Chrome DevTools (F12 or Cmd+Option+I)
   - Go to Console tab
   - You'll see logs like "Auto-admitting user via button: Admit [Name]"

#### Toggling On/Off

1. Click the extension icon in your toolbar
2. Click the toggle switch
3. Status updates:
   - ✓ **Green**: "Auto-admit is active" - extension is working
   - ⊘ **Gray**: "Auto-admit is paused" - extension is off

## Troubleshooting

### Extension not admitting people?

**Check these common issues:**

1. **Are you the host?**
   - You must be the meeting host or have permission to admit people
   - Check Google Meet settings

2. **Is the extension enabled?**
   - Click the extension icon
   - Verify the toggle is ON (green)

3. **Have you reloaded the page recently?**
   - Refresh the Google Meet tab after installing/updating the extension
   - The extension activates when the page loads

4. **Check the console for errors**
   - Open DevTools (F12)
   - Look for error messages in Console tab
   - Report issues on GitHub if you see errors

### People still waiting even with extension on?

1. **Try refreshing the Google Meet page**
   - Close and rejoin the meeting
   - This reloads the extension

2. **Verify meeting security settings**
   - Some enterprise Google Workspace settings may prevent auto-admission
   - Check with your IT administrator

3. **Check if they're using the correct meeting link**
   - External/guest users may require manual approval regardless
   - Some organizations block auto-admission for external users

### Extension icon missing?

1. Check if it's hidden
   - Click the puzzle piece icon in Chrome toolbar
   - Look for "Auto Admit for Google Meet"
   - Click the pin icon to make it visible

2. Verify installation
   - Go to `chrome://extensions/`
   - Find "Auto Admit for Google Meet"
   - Ensure it's enabled (toggle switch is blue/on)

## FAQ

**Q: Does this work for all Google Meet types?**
A: Yes, it works for standard meet.google.com meetings where you have host/admission permissions.

**Q: Will it admit everyone, even if I don't know them?**
A: Yes, the extension admits everyone who knocks. If you need control, toggle it off or use Google Meet's security settings to require host approval for specific domains.

**Q: Does it work in incognito mode?**
A: Only if you enable it for incognito in Chrome's extension settings (`chrome://extensions/` → "Allow in incognito").

**Q: Can I use this with multiple Google accounts?**
A: Yes, the extension works with all Google accounts in your browser.

**Q: Will it slow down my browser?**
A: No, it's very lightweight and only activates on Google Meet pages.

**Q: Is my data safe?**
A: Yes! The extension doesn't collect, store, or transmit any data. See [PRIVACY.md](PRIVACY.md) for details.

## Advanced Usage

### Checking if Extension is Loaded

1. Visit any Google Meet (even without a meeting)
2. Open DevTools Console (F12)
3. Look for "Auto Admit extension loaded" message
4. If you don't see it, refresh the page

### Monitoring Auto-Admission Activity

For transparency, you can watch the extension work:

1. Open Chrome DevTools (F12)
2. Go to Console tab
3. Look for these messages:
   - "Auto Admit extension loaded"
   - "Auto Admit extension initialized successfully"
   - "Found X participant(s) waiting to be admitted"
   - "Auto-admitting user via button: [Name]"

## Uninstalling

If you need to remove the extension:

1. Go to `chrome://extensions/`
2. Find "Auto Admit for Google Meet"
3. Click "Remove"
4. Confirm removal
5. All stored data (toggle preference) is automatically deleted

## Getting Help

**Need more help?**

1. Check the [README.md](README.md) for technical details
2. Visit our [GitHub Issues](https://github.com/slmingol/google-meet-auto-admit/issues)
3. Review the [Privacy Policy](PRIVACY.md)

**Report a bug:**
https://github.com/slmingol/google-meet-auto-admit/issues/new

**Feature requests welcome!**
