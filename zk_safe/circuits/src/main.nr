// Proves knowledge of a secret number (e.g., vault pass)
fn main(secret: Field, hash: Field) {
    let computed_hash = hash_poseidon([secret]);
    assert(computed_hash == hash);
}