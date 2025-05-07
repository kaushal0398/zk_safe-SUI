import { BarretenbergVerifier } from "@noir-lang/barretenberg";
import circuit from "./main.json";

export async function verifyProof(proof: Uint8Array, publicInputs: bigint[]): Promise<boolean> {
  const verifier = new BarretenbergVerifier(circuit);
  return await verifier.verifyProof(proof, publicInputs);
}