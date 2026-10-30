// Compare the offline joiner's incremental SHA-256 with Node's independent implementation.
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const vm = require('node:vm');
const template = fs.readFileSync(require('node:path').join(__dirname, 'joiner-template.html'), 'utf8');
const implementation = template.slice(template.indexOf('class Sha256 {'), template.indexOf('const byId='));
const Sha256 = vm.runInNewContext(`${implementation}\nSha256`);
for (const size of [0, 1, 55, 56, 63, 64, 65, 127, 128, 129, 1023, 1048577]) {
  const input = crypto.randomBytes(size);
  const expected = crypto.createHash('sha256').update(input).digest('hex');
  for (const step of [1, 17, 64, 65, 4096]) {
    const hash = new Sha256();
    for (let i = 0; i < size; i += step) hash.update(input.subarray(i, i + step));
    assert.equal(hash.hex(), expected, `size=${size}, chunk=${step}`);
  }
}
console.log('Incremental SHA-256 matches Node for 12 sizes and 5 chunk boundaries.');
