// Popup script for Auto Admit extension

const toggle = document.getElementById('autoAdmitToggle');
const statusDiv = document.getElementById('status');

// Load saved state
if (chrome.storage && chrome.storage.sync) {
  chrome.storage.sync.get(['autoAdmitEnabled'], (result) => {
    const enabled = result.autoAdmitEnabled !== false; // Default to true
    toggle.checked = enabled;
    updateStatus(enabled);
  });
} else {
  // Fallback if storage API not available
  toggle.checked = true;
  updateStatus(true);
}

// Handle toggle changes
toggle.addEventListener('change', async () => {
  const enabled = toggle.checked;
  
  // Save state
  if (chrome.storage && chrome.storage.sync) {
    chrome.storage.sync.set({ autoAdmitEnabled: enabled });
  }
  
  // Update status display
  updateStatus(enabled);
  
  // Send message to content script
  try {
    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
    if (tab && tab.url && tab.url.includes('meet.google.com')) {
      chrome.tabs.sendMessage(tab.id, {
        action: 'toggleAutoAdmit',
        enabled: enabled
      });
    }
  } catch (e) {
    console.error('Error sending message to content script:', e);
  }
});

function updateStatus(enabled) {
  if (enabled) {
    statusDiv.textContent = '✓ Auto-admit is active';
    statusDiv.className = 'status active';
  } else {
    statusDiv.textContent = '⊘ Auto-admit is paused';
    statusDiv.className = 'status';
  }
}
