# Privacy Policy for Auto Admit for Google Meet

**Last Updated:** March 18, 2026

## Overview
Auto Admit for Google Meet is a browser extension that automatically admits participants to your Google Meet calls. This privacy policy explains how the extension handles data.

## Data Collection
**We do not collect, store, or transmit any personal data.**

The extension:
- Does NOT collect any personal information
- Does NOT track your browsing activity
- Does NOT store meeting information
- Does NOT send data to external servers
- Does NOT use analytics or tracking tools

## Data Storage
The extension stores only one piece of information locally on your device:
- **On/Off Toggle State**: Whether auto-admit is enabled or disabled

This preference is stored using Chrome's `storage.sync` API and:
- Remains on your device only
- Syncs across your Chrome browsers if you're signed in to Chrome
- Can be cleared by removing the extension

## Permissions Explained
The extension requires the following permissions:

### activeTab
- **Purpose**: To interact with the current Google Meet tab
- **Usage**: Allows the extension to find and click "Admit" buttons in Google Meet

### storage
- **Purpose**: To remember your on/off preference
- **Usage**: Stores whether auto-admit is enabled or disabled

### host_permissions (meet.google.com)
- **Purpose**: To run only on Google Meet pages
- **Usage**: The extension only activates on Google Meet URLs

## Third-Party Access
- No third parties have access to any data
- No data is shared with anyone
- No advertisements or tracking

## Changes to Privacy Policy
We may update this privacy policy occasionally. Any changes will be posted in the extension repository and updated here.

## Contact
For questions about this privacy policy, please open an issue on our GitHub repository:
https://github.com/slmingol/google-meet-auto-admit

## Your Rights
You can:
- Disable the extension at any time
- Remove the extension to delete all stored data
- View the source code on GitHub to verify our claims

## Compliance
This extension complies with:
- Chrome Web Store Developer Program Policies
- General Data Protection Regulation (GDPR)
- California Consumer Privacy Act (CCPA)
