const fs = require("fs");
const circomlibjs = require("circomlibjs"); // install with: npm i circomlibjs
const { buildPoseidon } = circomlibjs;

async function main() {
  const poseidon = await buildPoseidon();
  const secret = BigInt(123456); // change as needed

  const hash = poseidon([secret]);
  const pubHash = poseidon.F.toString(hash);

  const input = {
    secret: secret.toString(),
    pub_hash: pubHash
  };

  fs.writeFileSync("input.json", JSON.stringify(input, null, 2));
  console.log("✅ input.json generated:\n", input);
}

main();
