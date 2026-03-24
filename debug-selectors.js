// Debug script to test if admit button selectors work
// Run this in the browser console on a Google Meet page when someone is waiting

console.log('=== Google Meet Auto-Admit Debug ===');

const selectors = [
  'button[aria-label*="Admit"]',
  'button[data-tooltip*="Admit"]',
  '[role="button"][aria-label*="Admit"]',
  'button[jsname][aria-label*="Admit"]',
  'div[role="button"][aria-label*="Admit"]',
  'button[data-idom-class*="admit"]',
  'button[class*="admit"]'
];

console.log('\nTesting selectors:\n');

let totalFound = 0;
selectors.forEach((selector, index) => {
  try {
    const elements = document.querySelectorAll(selector);
    if (elements.length > 0) {
      console.log(`✓ Selector ${index + 1}: "${selector}" - Found ${elements.length} element(s)`);
      elements.forEach((el, i) => {
        const ariaLabel = el.getAttribute('aria-label');
        const role = el.getAttribute('role');
        const tag = el.tagName.toLowerCase();
        console.log(`  [${i + 1}] <${tag}> aria-label="${ariaLabel}" role="${role}"`);
      });
      totalFound += elements.length;
    } else {
      console.log(`✗ Selector ${index + 1}: "${selector}" - No matches`);
    }
  } catch (e) {
    console.error(`✗ Selector ${index + 1}: "${selector}" - Error:`, e.message);
  }
});

console.log(`\nTotal elements found: ${totalFound}`);

// Also search for any button or clickable element with "admit" in it
console.log('\n=== Generic admit search ===');
const allButtons = document.querySelectorAll('button, [role="button"], div[class*="button"]');
const admitElements = Array.from(allButtons).filter(el => {
  const text = el.textContent.toLowerCase();
  const ariaLabel = (el.getAttribute('aria-label') || '').toLowerCase();
  const tooltip = (el.getAttribute('data-tooltip') || '').toLowerCase();
  return text.includes('admit') || ariaLabel.includes('admit') || tooltip.includes('admit');
});

console.log(`Found ${admitElements.length} element(s) containing "admit":`);
admitElements.forEach((el, i) => {
  console.log(`[${i + 1}]`, {
    tag: el.tagName,
    text: el.textContent.trim().substring(0, 50),
    ariaLabel: el.getAttribute('aria-label'),
    classes: el.className,
    element: el
  });
});

console.log('\n=== Check extension status ===');
console.log('Extension loaded:', window.autoAdmitTimeout !== undefined || 'Unknown');
