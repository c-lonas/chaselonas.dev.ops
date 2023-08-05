const fs = require('fs-extra');
const path = require('path');

const srcDir = path.join(__dirname, 'src', 'public');
const destDir = path.join(__dirname, 'dist', 'public');

fs.copySync(srcDir, destDir, { recursive: true });
console.log('Static assets copied successfully!');
