module zk_safe::vault {
    use sui::object::UID;
    use sui::tx_context::TxContext;
    use sui::transfer;

    public struct Vault has key, store {
        id: UID,
        encrypted_data: vector<vector<u8>>,
    }

    public fun new(ctx: &mut TxContext): Vault {
        Vault {
            id: object::new(ctx),
            encrypted_data: vector::empty<vector<u8>>()
        }
    }

    public fun add_data(vault: &mut Vault, data: vector<u8>) {
        vector::push_back(&mut vault.encrypted_data, data);
    }

    public fun remove_data(vault: &mut Vault, index: u64) {
        vector::remove(&mut vault.encrypted_data, index);
    }

    public fun get_data(vault: &Vault, index: u64): &vector<u8> {
        vector::borrow(&vault.encrypted_data, index)
    }

    public fun get_count(vault: &Vault): u64 {
        vector::length(&vault.encrypted_data)
    }

    public fun transfer_vault(vault: Vault, recipient: address) {
        transfer::public_transfer(vault, recipient);
    }

    public fun get_protected_data(vault: &Vault, index: u64, proof: vector<u8>, expected_hash: vector<u8>): &vector<u8> {
        // TODO: integrate zkProof verification in Move once supported
        // Check proof validity here...
        vault::get_data(vault, index)
    }
} 