    module zk_safe::vault_tests {
    use zk_safe::vault;
    // use sui::tx_context::TxContext;

    #[test_only]
    fun test_unlock_success(ctx: &mut TxContext) {
        let mut v = vault::test_create(ctx);

        let correct_pub_input = vector[
            132u8, 24u8, 89u8, 232u8, 77u8, 12u8, 34u8, 145u8,
            201u8, 144u8, 111u8, 9u8, 83u8, 199u8, 182u8, 33u8,
            44u8, 188u8, 100u8, 72u8, 1u8, 222u8, 173u8, 109u8,
            160u8, 255u8, 21u8, 78u8, 77u8, 2u8, 23u8, 7u8
        ];

        vault::unlock(&mut v, correct_pub_input);
        assert!(vault::is_unlocked(&v));

        vault::destroy(v);
    }
}
