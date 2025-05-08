use poseidon2::poseidon2_permute;

fn main(secret: Field, pub_hash: Field) {
    let input: [Field; 4] = [secret, 0, 0, 0];
    let out: [Field; 4] = poseidon2_permute(input); // add type annotation here
    assert(pub_hash == out[0]);
}