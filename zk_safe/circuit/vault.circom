pragma circom 2.0.0;

include "circomlib/circuits/poseidon.circom";
include "circomlib/circuits/comparators.circom";

template VaultAuth() {
    signal input secret;
    signal input pub_hash;
    signal output valid;

    component hash = Poseidon(1);
    hash.inputs[0] <== secret;

    component isEq = IsEqual();
    isEq.in[0] <== hash.out;
    isEq.in[1] <== pub_hash;

    valid <== isEq.out;
}

component main = VaultAuth();
