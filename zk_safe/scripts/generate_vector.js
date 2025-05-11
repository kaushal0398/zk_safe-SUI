const pub = require("../circuit/public.json");
const bytes = BigInt(pub[0]).toString(16).padStart(64, "0").match(/.{1,2}/g).map(b => parseInt(b, 16));
const output = bytes.map(b => `${b}u8`).join(", ");
console.log(`vector[${output}]`);
