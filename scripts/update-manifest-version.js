#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Get the repository root directory
const repoRoot = path.join(__dirname, '..');

// Read package.json version
const packageJson = require(path.join(repoRoot, 'package.json'));
const version = packageJson.version;

// Read manifest.json
const manifestPath = path.join(repoRoot, 'manifest.json');
const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));

// Update version
manifest.version = version;

// Write back to manifest.json
fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2) + '\n');

console.log(`Updated manifest.json to version ${version}`);
