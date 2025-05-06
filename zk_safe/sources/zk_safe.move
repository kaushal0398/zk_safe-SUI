module zk_safe::vault {
    use sui::object::UID;
    use sui::tx_context::TxContext;
    use sui::transfer;

    public struct Vault has key, store {
        id: UID,
        encrypted_data: vector<vector<u8>>,
    }

    public(package) fun new(ctx: &mut TxContext): Vault {
        Vault {
            id: object::new(ctx),
            encrypted_data: vector::empty<vector<u8>>()
        }
    }

    public(package) fun add_data(vault: &mut Vault, data: vector<u8>) {
        vector::push_back(&mut vault.encrypted_data, data);
    }

    public(package) fun remove_data(vault: &mut Vault, index: u64) {
        vector::remove(&mut vault.encrypted_data, index);
    }

    public(package) fun get_count(vault: &Vault): u64 {
        vector::length(&vault.encrypted_data)
    }

    public(package) fun transfer_vault(vault: Vault, recipient: address) {
        transfer::public_transfer(vault, recipient);
    }

    public(package) fun get_data(vault: &Vault, index: u64): &vector<u8> {
        vector::borrow(&vault.encrypted_data, index)
    }
}
