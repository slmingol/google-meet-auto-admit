// Auto Admit for Google Meet - Content Script

console.log('Auto Admit extension loaded');

let isAutoAdmitEnabled = true;
let observerInstance = null;
let isInitialized = false;

// Configuration
const CONFIG = {
  checkInterval: 1000, // Check every second
  buttonSelectors: [
    // Updated selectors for current Google Meet UI (2026)
    'button[aria-label*="Admit"]',
    'button[data-tooltip*="Admit"]',
    '[role="button"][aria-label*="Admit"]',
    'button[jsname][aria-label*="Admit"]',
    'div[role="button"][aria-label*="Admit"]',
    // Specific to individual admit buttons (not "Admit all")
    'button[data-idom-class*="admit"]',
    'button[class*="admit"]'
  ]
};

/**
 * Find admit buttons in the DOM
 */
function findAdmitButtons() {
  const buttons = [];
  const seenButtons = new Set(); // Prevent duplicates
  
  for (const selector of CONFIG.buttonSelectors) {
    try {
      const elements = document.querySelectorAll(selector);
      elements.forEach(el => {
        // Skip if already processed
        if (seenButtons.has(el)) return;
        
        const ariaLabel = (el.getAttribute('aria-label') || '').toLowerCase();
        const tooltip = (el.getAttribute('data-tooltip') || '').toLowerCase();
        const text = el.textContent.toLowerCase();
        
        // Check if it's an admit button (individual, not "Admit all")
        const hasAdmit = ariaLabel.includes('admit') || tooltip.includes('admit') || text.includes('admit');
        const isAdmitAll = ariaLabel.includes('admit all') || tooltip.includes('admit all') || text.includes('admit all');
        
        if (hasAdmit && !isAdmitAll) {
          buttons.push(el);
          seenButtons.add(el);
          console.log('Found admit button:', ariaLabel || tooltip || text);
        }
      });
    } catch (e) {
      console.error('Error finding buttons with selector:', selector, e);
    }
  }
  
  return buttons;
}

/**
 * Click admit button with safety checks
 */
function clickAdmitButton(button) {
  try {
    if (!button || !button.isConnected) {
      return false;
    }
    
    // Check if button is visible and enabled
    const rect = button.getBoundingClientRect();
    if (rect.width === 0 || rect.height === 0) {
      return false;
    }
    
    const isDisabled = button.disabled || 
                      button.getAttribute('aria-disabled') === 'true' ||
                      button.classList.contains('disabled');
    
    if (isDisabled) {
      return false;
    }
    
    console.log('Auto-admitting user via button:', button.getAttribute('aria-label'));
    button.click();
    return true;
  } catch (e) {
    console.error('Error clicking admit button:', e);
    return false;
  }
}

/**
 * Check for and admit waiting participants
 */
function checkAndAdmitParticipants() {
  if (!isAutoAdmitEnabled) {
    return;
  }
  
  const admitButtons = findAdmitButtons();
  
  if (admitButtons.length > 0) {
    console.log(`Found ${admitButtons.length} participant(s) waiting to be admitted`);
    
    admitButtons.forEach(button => {
      clickAdmitButton(button);
    });
  }
}

/**
 * Setup MutationObserver to watch for DOM changes
 */
function setupObserver() {
  // Disconnect existing observer if any
  if (observerInstance) {
    observerInstance.disconnect();
  }
  
  observerInstance = new MutationObserver((mutations) => {
    // Debounce checks - only check after DOM has settled
    clearTimeout(window.autoAdmitTimeout);
    window.autoAdmitTimeout = setTimeout(checkAndAdmitParticipants, 300);
  });
  
  // Observe the entire document for changes
  observerInstance.observe(document.body, {
    childList: true,
    subtree: true,
    attributes: true,
    attributeFilter: ['aria-label', 'data-tooltip']
  });
  
  console.log('MutationObserver setup complete');
}

/**
 * Initialize the extension
 */
async function init() {
  if (isInitialized) {
    console.log('Auto Admit already initialized');
    return;
  }
  
  console.log('Initializing Auto Admit extension...');
  
  // Wait for the page to be fully loaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
    return;
  }
  
  // Load saved state from storage BEFORE starting
  try {
    if (chrome.storage && chrome.storage.sync) {
      const result = await chrome.storage.sync.get(['autoAdmitEnabled']);
      isAutoAdmitEnabled = result.autoAdmitEnabled !== false; // Default to true
      console.log('Loaded auto-admit state from storage:', isAutoAdmitEnabled);
    }
  } catch (e) {
    console.warn('Could not load state from storage:', e);
  }
  
  // Setup observer for DOM changes
  setupObserver();
  
  // Also do periodic checks as backup
  setInterval(checkAndAdmitParticipants, CONFIG.checkInterval);
  
  // Initial check
  setTimeout(checkAndAdmitParticipants, 2000);
  
  isInitialized = true;
  console.log('Auto Admit extension initialized successfully. Status:', isAutoAdmitEnabled ? 'ENABLED' : 'DISABLED');
}

// Listen for messages from popup
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.action === 'toggleAutoAdmit') {
    isAutoAdmitEnabled = message.enabled;
    console.log('Auto admit:', isAutoAdmitEnabled ? 'ENABLED' : 'DISABLED');
    
    // Also save to storage to ensure consistency
    if (chrome.storage && chrome.storage.sync) {
      chrome.storage.sync.set({ autoAdmitEnabled: isAutoAdmitEnabled });
    }
    
    sendResponse({ success: true, enabled: isAutoAdmitEnabled });
  } else if (message.action === 'getStatus') {
    sendResponse({ enabled: isAutoAdmitEnabled });
  }
  return true;
});

// Start the extension
init();
