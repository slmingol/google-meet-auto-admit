// Auto Admit for Google Meet - Content Script

console.log('Auto Admit extension loaded');

let isAutoAdmitEnabled = true;
let observerInstance = null;

// Configuration
const CONFIG = {
  checkInterval: 1000, // Check every second
  buttonSelectors: [
    '[aria-label*="Admit"]',
    'button[aria-label*="Admit"]',
    '[data-tooltip*="Admit"]',
    'button[jsname][aria-label*="Admit"]'
  ]
};

/**
 * Find admit buttons in the DOM
 */
function findAdmitButtons() {
  const buttons = [];
  
  for (const selector of CONFIG.buttonSelectors) {
    try {
      const elements = document.querySelectorAll(selector);
      elements.forEach(el => {
        const ariaLabel = el.getAttribute('aria-label') || '';
        const tooltip = el.getAttribute('data-tooltip') || '';
        
        // Check if it's an admit button (not "Admit all" which we handle separately)
        if (ariaLabel.toLowerCase().includes('admit') || tooltip.toLowerCase().includes('admit')) {
          buttons.push(el);
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
function init() {
  console.log('Initializing Auto Admit extension...');
  
  // Wait for the page to be fully loaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
    return;
  }
  
  // Setup observer for DOM changes
  setupObserver();
  
  // Also do periodic checks as backup
  setInterval(checkAndAdmitParticipants, CONFIG.checkInterval);
  
  // Initial check
  setTimeout(checkAndAdmitParticipants, 2000);
  
  console.log('Auto Admit extension initialized successfully');
}

// Listen for messages from popup
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.action === 'toggleAutoAdmit') {
    isAutoAdmitEnabled = message.enabled;
    console.log('Auto admit:', isAutoAdmitEnabled ? 'enabled' : 'disabled');
    sendResponse({ success: true, enabled: isAutoAdmitEnabled });
  } else if (message.action === 'getStatus') {
    sendResponse({ enabled: isAutoAdmitEnabled });
  }
  return true;
});

// Start the extension
init();
