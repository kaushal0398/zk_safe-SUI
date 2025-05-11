module zk_safe::vault {
    use sui::object::{UID, Self};
    use sui::tx_context::{TxContext, sender};
    use std::vector;
    use sui::transfer;

    public struct Vault has key, store {
        id: UID,
        unlocked: bool,
    }

    public entry fun create(ctx: &mut TxContext) {
        let vault = Vault {
            id: object::new(ctx),
            unlocked: false,
        };
        transfer::transfer(vault, sender(ctx));
    }

    public entry fun unlock(v: &mut Vault, pub_input: vector<u8>) {
        let expected = vector[
            132u8, 24u8, 89u8, 232u8, 77u8, 12u8, 34u8, 145u8,
            201u8, 144u8, 111u8, 9u8, 83u8, 199u8, 182u8, 33u8,
            44u8, 188u8, 100u8, 72u8, 1u8, 222u8, 173u8, 109u8,
            160u8, 255u8, 21u8, 78u8, 77u8, 2u8, 23u8, 7u8
        ];

        if (!vector::content_equal(&pub_input, &expected)) {
            abort 0xBAD;
        };

        v.unlocked = true;
    }
} 
