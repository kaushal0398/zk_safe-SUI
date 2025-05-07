module zk_safe::vault_test {
    use zk_safe::vault;
    use sui::tx_context::TxContext;

    #[test(ctx = @0x1)]
    public fun test_vault_add_remove(ctx: &mut TxContext) {
        let mut v = vault::new(ctx);

        let secret1 = vector::singleton(0xAB);
        let secret2 = vector::singleton(0xCD);

        vault::add_data(&mut v, secret1);
        vault::add_data(&mut v, secret2);
        assert!(vault::get_count(&v) == 2);

        vault::remove_data(&mut v, 0);
        assert!(vault::get_count(&v) == 1);
    }

    #[test(ctx = @0x1)]
    public fun test_vault_transfer(ctx: &mut TxContext) {
        let vault_obj = vault::new(ctx);
        vault::transfer_vault(vault_obj, @0xCAFE);
    }
}