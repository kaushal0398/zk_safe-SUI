# 🔐 zkSafe: Zero-Knowledge Secure Vault on Sui

zkSafe is a modular, pluggable zero-knowledge infrastructure protocol that enables private vault creation and access control on the Sui blockchain. Designed with DAO-readiness, pluggable ZK verifiers, and secure access primitives, it acts as the foundational layer for decentralized access control and composability.

---

## 🧠 Architecture

```
USER INTERACTION → PROOF GENERATOR → VERIFIER ENGINE → zkVault MOVE MODULE → DAO / Owner
```

* **Frontend/CLI (User Interaction Layer)**: Connects wallet and generates proof.
* **Proof System (zkSNARKs)**: Off-chain witness generation, hashes secrets using Poseidon, Circom.
* **zkVault Move Module (Smart Contract Core)**: Enforces unlock logic using simulated `vector::equals()` for now.
* **Access Control Layer**: Ownership support for DAOs, composability and registration support.
* **Deployment Layer**: CLI, CI/CD, lifecycle versioning, and testnet/mainnet support.

---

## 📁 Project Structure

```
zk_safe-SUI/
├── Move.toml                     # Move manifest
├── sources/
│   └── zk_safe.move              # Main Move logic (vault struct, create, unlock)
├── tests/
│   └── zk_safe_tests.move        # Unit tests for vault behavior
├── circuit/
│   ├── vault.circom              # Circom circuit for ZK proof
│   ├── proof.json                # Groth16 ZK proof
│   ├── public.json               # Public inputs (sent to chain)
│   ├── witness.wtns              # Witness from input.json
│   ├── circuit_final.zkey        # Final proving key
│   ├── pot12_final.ptau          # Trusted setup output
│   └── vault_js/                 # WASM + JS witness generator
│       └── generate_witness.js
├── zk/
│   └── runProof.ts               # Node script to generate ZK proof
├── package.json, tsconfig.json  # TypeScript setup
```

---

## 🛠️ Setup Instructions

### 🔐 ZK Trusted Setup + Proofs (Groth16)

```bash
# Remove any previous PTAU files
rm pot12_*.ptau

# Step 1: Powers of Tau Ceremony
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

# Step 2: Entropy contribution
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="zkSafe Setup" -v

# Step 3: Prepare phase2
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v

# Step 4: Generate proving/verifying keys
snarkjs groth16 setup vault.r1cs pot12_final.ptau circuit_final.zkey

# Step 5: Export verification key
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json
```

### 🧾 Proof Generation

```bash
# Generate a ZK proof
snarkjs groth16 prove circuit_final.zkey witness.wtns proof.json public.json

# (Optional) Verify it locally
snarkjs groth16 verify verification_key.json public.json proof.json
```

---

## 🧪 Run Tests

```bash
sui move test
```

---

## 🚀 Deploy & Interact with Vault

### Build & Publish

```bash
sui move build

sui client publish --gas-budget 100000000
```

### Create Vault

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module vault \
  --function create \
  --gas-budget 100000000
```

### Unlock Vault

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module vault \
  --function unlock \
  --args <VAULT_ID> '[132,24,89,...]' \
  --gas-budget 100000000
```

---

## ✅ Features

* 🔒 zk-Based vault unlock logic
* 📜 Move-native smart contracts
* 🧩 Modular Circom proof engine
* 🤝 DAO & shared ownership compatibility
* 🧠 Simulated vector equality until Sui-native Groth16 support

---

## 🤖 Tech Stack

* Move (on Sui)
* Circom + SnarkJS
* TypeScript for proof generation
* CLI & testnet integration

---

## 📌 Future Work

* Native Groth16 verifier integration with Sui
* Noir circuit support (optional)
* zkLogin integration for social onboarding
* UI frontend for DAO vault management

---

## 📚 License

MIT License — feel free to fork and build on this!

---

