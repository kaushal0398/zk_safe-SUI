module zk_safe::vault {
    use sui::object::new;
    use sui::tx_context::sender;

    public struct Vault has key, store {
        id: UID,
        unlocked: bool,
    }

    public entry fun create(ctx: &mut TxContext) {
        let vault = Vault {
            id: new(ctx),
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

        assert!(vector::length(&pub_input) == vector::length(&expected), 0xBAD);

        let len = vector::length(&pub_input);
        let mut i = 0;
        while (i < len) {
        let a = *vector::borrow(&pub_input, i);
        let b = *vector::borrow(&expected, i);
        assert!(a == b, 0xBAD);
        i = i + 1;
    };

        v.unlocked = true;
    }

    // For unit testing
    public fun test_create(ctx: &mut TxContext): Vault {
        Vault {
            id: new(ctx),
            unlocked: false,
        }
    }
}
