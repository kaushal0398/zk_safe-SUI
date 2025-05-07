def main(secret: Field, pub_hash: pub Field) {
    // Hash the secret
    let hashed_secret = hash(secret);

    // Check if it matches the public hash
    assert(pub_hash == hashed_secret);
}