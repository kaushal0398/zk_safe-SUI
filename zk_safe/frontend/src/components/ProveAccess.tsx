import { useState } from 'react';
import { poseidon } from 'circomlibjs';

export default function ProveAccess() {
  const [secret, setSecret] = useState('');
  const [proof, setProof] = useState('');

  async function generate() {
    const input = BigInt(secret);
    const hash = poseidon([input]).toString();
    const res = await fetch('/api/prove', {
      method: 'POST',
      body: JSON.stringify({ input, hash })
    });
    const { proof } = await res.json();
    setProof(proof);
  }

  return (
    <div>
      <input onChange={e => setSecret(e.target.value)} placeholder="Secret" />
      <button onClick={generate}>Generate ZK Proof</button>
      <pre>{proof}</pre>
    </div>
  );
}