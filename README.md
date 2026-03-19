# Auto Admit for Google Meet - Chrome Extension

Automatically admits people to your Google Meet calls when they're in the waiting room.

## Features

- 🚀 Automatically admits participants waiting to join
- 🎯 Works continuously while you're in a meeting
- 🔄 Can be toggled on/off from the extension popup
- 🔍 Monitors DOM changes in real-time for instant admission
- 🛡️ Safe and respects Google Meet's UI

## Installation (Developer Mode)

1. **Clone/Download** this extension folder to your computer

2. **Open Chrome Extensions Page**
   - Navigate to `chrome://extensions/`
   - Or click the puzzle piece icon → "Manage Extensions"

3. **Enable Developer Mode**
   - Toggle the "Developer mode" switch in the top-right corner

4. **Load the Extension**
   - Click "Load unpacked"
   - Select the `google-meet-auto-admit` folder
   - The extension should now appear in your extensions list

5. **Pin the Extension** (Optional)
   - Click the puzzle piece icon in Chrome toolbar
   - Find "Auto Admit for Google Meet"
   - Click the pin icon to keep it visible

## Usage

1. **Join a Google Meet** as the host or co-host

2. **The extension runs automatically** - when someone knocks to join, they'll be admitted automatically

3. **Toggle On/Off**
   - Click the extension icon in your toolbar
   - Use the toggle switch to enable/disable auto-admit
   - The status will update to show the current state

4. **Check Console** (Optional)
   - Open Developer Tools (F12)
   - Go to Console tab
   - You'll see logs when the extension admits participants

## How It Works

The extension:
1. Monitors the Google Meet page for DOM changes
2. Looks for "Admit" buttons in the participants panel
3. Automatically clicks those buttons when detected
4. Runs checks every second as a backup
5. Respects the enabled/disabled state from the popup

## Permissions Explained

- **activeTab**: Allows the extension to interact with the current Google Meet tab
- **host_permissions (meet.google.com)**: Necessary to inject the content script into Google Meet pages

## Customization

You can adjust the behavior by editing `content.js`:

- **Check interval**: Change `checkInterval` (default: 1000ms)
- **Button selectors**: Modify `buttonSelectors` array if Google Meet's DOM changes
- **Debounce delay**: Adjust the 300ms timeout in the MutationObserver

## Troubleshooting

**Extension not working?**
- Make sure you're the host or have permission to admit participants
- Check that the extension is enabled in `chrome://extensions/`
- Refresh the Google Meet page after installing/updating the extension
- Open DevTools Console to see debug logs

**Extension admitting incorrectly?**
- Toggle it off temporarily from the popup
- Report the issue with console logs

**Google Meet updated their UI?**
- The extension may need updates to match new button selectors
- Check console for errors

## Privacy

This extension:
- ✅ Only runs on meet.google.com
- ✅ Does not collect any data
- ✅ Does not make external network requests
- ✅ Stores only your enable/disable preference locally

## Development

To modify the extension:

1. Edit the files in this folder
2. Go to `chrome://extensions/`
3. Click the refresh icon on the extension card
4. Reload your Google Meet page to test changes

## Icons

The extension currently references icon files (icon16.png, icon48.png, icon128.png) that need to be created. You can:
- Create simple icons using any image editor
- Use a placeholder icon
- Or remove the icons section from manifest.json temporarily

## License

MIT License - Feel free to modify and use as needed.

## Version

Current version: 1.0.14
