# Troubleshooting Guide

## Extension Not Working? Try These Steps

### 1. Verify Extension is Loaded and Active

**Check if the extension is installed:**
1. Go to `chrome://extensions/`
2. Find "Auto Admit for Google Meet"
3. Ensure it's **enabled** (toggle switch is blue/on)
4. Check that "Developer mode" is ON

**Verify it's running on the Meet page:**
1. Join a Google Meet (you must be host or co-host)
2. Press F12 to open Developer Tools
3. Go to the **Console** tab
4. You should see messages like:
   - `Auto Admit extension loaded`
   - `Initializing Auto Admit extension...`
   - `Loaded auto-admit state from storage: true`
   - `Auto Admit extension initialized successfully. Status: ENABLED`

### 2. Check Extension Status

**Make sure auto-admit is enabled:**
1. Click the extension icon in your Chrome toolbar
2. Verify the toggle is **ON** (blue)
3. Status should say "✓ Auto-admit is active"

If it says "⊘ Auto-admit is paused", toggle it back on.

### 3. Test with Debug Script

When someone is waiting to join your meeting:

1. Press F12 to open Developer Tools
2. Go to **Console** tab
3. Copy and paste the entire contents of `debug-selectors.js`
4. Press Enter

**What to look for:**
- It should show which selectors found admit buttons
- If "Total elements found: 0", Google Meet's UI has changed
- The "Generic admit search" section shows ALL elements with "admit"

### 4. Reload the Extension

Sometimes Chrome needs a refresh:

1. Go to `chrome://extensions/`
2. Find "Auto Admit for Google Meet"
3. Click the **reload icon** (circular arrow)
4. Refresh your Google Meet tab

### 5. Check Permissions

1. Go to `chrome://extensions/`
2. Click "Details" on the extension
3. Scroll to "Site access"
4. Ensure it says "On specific sites" and includes `meet.google.com`

### 6. Google Meet UI Changed

If the selectors aren't finding buttons, Google may have updated their UI:

**To fix:**
1. Use the debug script (step 3) to find the current button structure
2. Look at the "Generic admit search" results
3. Note the classes, aria-labels, or other attributes
4. Update the selectors in `content.js` in the `CONFIG.buttonSelectors` array

Example: If you find buttons with `data-meet-admit="true"`, add:
```javascript
'button[data-meet-admit="true"]'
```

### 7. Manifest V3 Issues

If you see errors about "service workers" or "manifest version":

This extension uses Manifest V3 which is required for modern Chrome. Ensure you're using:
- Chrome 88 or later
- Edge 88 or later
- Brave 1.20 or later

## Common Issues

### "Extension doesn't admit anyone"
- Verify you're the **host or co-host** (Google only shows admit buttons to hosts)
- Check the console for "Found X participant(s) waiting"
- Use debug script to verify selectors work

### "Extension admits too slowly"
- Default check interval is 1 second
- Can modify `checkInterval` in `content.js` CONFIG (in milliseconds)

### "Extension icon doesn't appear"
- Pin the extension: Click puzzle piece → find extension → click pin icon

### "Toggle doesn't persist"
- Check browser console for storage errors
- Extension should save state to chrome.storage.sync

## Recent Fixes (v1.0.15)

1. **State synchronization bug fixed**: Extension now loads saved on/off state on startup
2. **Improved selectors**: Added more selector patterns for current Google Meet UI
3. **Better duplicate prevention**: Prevents clicking the same button multiple times
4. **Enhanced logging**: More detailed console messages for debugging
5. **Excluded "Admit all" button**: Only admits individual participants

## Getting Help

If none of these steps work:

1. Run the debug script and save the output
2. Note your Chrome version (`chrome://version/`)
3. Note when the issue started
4. Check if Google Meet had a recent UI update
5. Open an issue on GitHub with the above information
