import fs from "fs";

export async function generateProof(inputPath = "input.json") {
  const input = JSON.parse(fs.readFileSync(inputPath).toString());

  const { proof, publicSignals } = await groth16.fullProve(
    input,
    "circuit/vault_js/vault.wasm",
    "circuit_final.zkey"
  );

  fs.writeFileSync("proof.json", JSON.stringify(proof, null, 2));
  fs.writeFileSync("public.json", JSON.stringify(publicSignals, null, 2));

  console.log("✅ Proof generated.");
  console.log("Public: ", publicSignals);

  return { proof, publicSignals };
}
