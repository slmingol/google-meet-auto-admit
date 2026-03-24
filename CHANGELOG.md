# Changelog

All notable changes to the Google Meet Auto-Admit extension will be documented in this file.

## [1.0.15] - 2026-03-24

### Fixed
- **Critical: State synchronization bug** - Extension now properly loads saved on/off state from storage on initialization
  - Previously, content script always started with auto-admit enabled regardless of user settings
  - Now checks chrome.storage.sync on startup to respect user preferences
- Content script now saves state changes to storage for consistency

### Improved
- **Better button selectors** - Updated selectors for current Google Meet UI
  - Added `[role="button"]` patterns
  - Added class-based selectors as fallback
  - More comprehensive aria-label matching
- **Enhanced button detection**
  - Prevents duplicate button clicks using Set tracking
  - Better filtering to exclude "Admit all" button
  - Checks button text content in addition to attributes
  - More detailed console logging for debugging
- **Popup synchronization** - Popup now queries content script for actual state, not just storage
- Added initialization guard to prevent double-initialization

### Added
- `debug-selectors.js` - Debugging script to test button selectors in browser console
- `docs/TROUBLESHOOTING.md` - Comprehensive troubleshooting guide
- Enhanced console logging with clearer status messages

### Technical
- Made `init()` function async to properly await storage loading
- Added `isInitialized` flag to prevent race conditions
- Improved error handling in storage operations

## [1.0.14] - Previous Release

(Earlier version before fixes)

---

## How to Update

1. Go to `chrome://extensions/`
2. Find "Auto Admit for Google Meet"
3. Click the **reload** button (circular arrow icon)
4. Refresh any open Google Meet tabs

The version number in the popup should now show `v1.0.15`.
