module ocean_token::ocean {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap, DenyCap};
    use sui::deny_list::DenyList;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    struct OCEAN has drop {}

    fun init(witness: OCEAN, ctx: &mut TxContext)
    {
        let icon_url = url::new_unsafe_from_bytes(b"https://file.walletapp.waveonsui.com/logos/ocean.png");
        let (treasury_cap, deny_cap, metadata) = coin::create_regulated_currency<OCEAN>(
            witness,
            9,
            b"OCEAN",
            b"Ocean Token",
            b"Ocean Token is a digital asset built on sui blockchain",
            option::some(icon_url),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        transfer::public_transfer(deny_cap, tx_context::sender(ctx));
    }

    public entry fun mint(treasury_cap: &mut TreasuryCap<OCEAN>, amount: u64, ctx: &mut TxContext)
    {
        coin::mint_and_transfer(treasury_cap, amount, tx_context::sender(ctx), ctx);
    }

    public entry fun burn(treasury_cap: &mut TreasuryCap<OCEAN>, coin: Coin<OCEAN>) {
        coin::burn(treasury_cap, coin);
    }

    entry fun block_account(
        deny_list: &mut DenyList,
        deny_cap: &mut DenyCap<OCEAN>,
        account: address,
        ctx: &mut TxContext
    ) {
        coin::deny_list_add(deny_list, deny_cap, account, ctx);
    }

    /// Remove an account from denylist allowing them to use the currency.
    /// DenyList is a special shared object with reserved address `0x403`.
    entry fun unblock_account(
        deny_list: &mut DenyList,
        deny_cap: &mut DenyCap<OCEAN>,
        account: address,
        ctx: &mut TxContext
    ) {
        coin::deny_list_remove(deny_list, deny_cap, account, ctx);
    }

    public entry fun transfer_treasury_cap(treasury_cap: TreasuryCap<OCEAN>, recipient: address)
    {
        transfer::public_transfer(treasury_cap, recipient);
    }

    public entry fun transfer_deny_cap(deny_cap: DenyCap<OCEAN>, recipient: address)
    {
        transfer::public_transfer(deny_cap, recipient);
    }
}