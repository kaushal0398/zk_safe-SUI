module zk_safe::vault_test {
    use zk_safe::vault;
    use sui::tx_context::TxContext;

    #[test]
    public fun test_add_and_remove_data(ctx: &mut TxContext) {
        let mut v = vault::new(ctx);

        let secret1 = vector::singleton(0xAB);
        let secret2 = vector::singleton(0xCD);

        vault::add_data(&mut v, secret1);
        vault::add_data(&mut v, secret2);
        assert!(vault::get_count(&v) == 2);

        vault::remove_data(&mut v, 0);
        assert!(vault::get_count(&v) == 1);
    }
}

