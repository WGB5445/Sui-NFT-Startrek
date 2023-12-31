module contract::nft_sbt{
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::display;
    use sui::package;
    use std::string::utf8;
    struct NFT_SBT has drop {}

    struct MySBT has key{
        id: UID,
        tokenId: u64
    }
    
    // testnet: 0xa600b1a23ff9fdc4b8ed9bcc9adeaa22ee1a21b1f71c2b0fbf5debfa15dbc5a9
    struct State has key {
        id: UID,
        count: u64
    }

    fun init(witness: NFT_SBT, ctx:&mut TxContext){
        let keys = vector[
            utf8(b"name"),
            utf8(b"collection"),
            utf8(b"image_url"),
            utf8(b"description")
        ];

        let values = vector[
            utf8(b"MySBT #{tokenId}"),
            utf8(b"MySBT Collection"),
            utf8(b"ipfs://QmPbxeGcXhYQQNgsC6a36dDyYUcHgMLnGKnF8pVFmGsvqi"),
            utf8(b"This is My SBT")
        ];

        let publisher = package::claim(witness,ctx);
        // testnet: 0xa79ce55e233d81e8bc8473e8ee8ef0b13adaac2075d602b8b5d91e7690455e45
        let display = display::new_with_fields<MySBT>(&publisher, keys, values, ctx);
        display::update_version(&mut display);
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));

        transfer::share_object(State{
            id: object::new(ctx),
            count: 0
        });
    
    }

    entry public fun mint( state:&mut State, ctx: &mut TxContext){
        let sender = tx_context::sender(ctx);
        state.count = state.count + 1;
        let nft = MySBT {
            id: object::new(ctx),
            tokenId: state.count,
        };
        transfer::transfer(nft, sender);
    }

}
