module contract::nft{
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::display;
    use sui::package;
    use std::string::utf8;
    struct NFT has drop {}

    struct MyNFT has key,store{
        id: UID,
        tokenId: u64
    }
    // testnet: 0x624b085fe39b356f8de1da6d867a541ba3f44fb41a7bb4ede6070f6d86ee0e2c
    struct State has key {
        id: UID,
        count: u64
    }

    fun init(witness: NFT, ctx:&mut TxContext){
        let keys = vector[
            utf8(b"name"),
            utf8(b"collection"),
            utf8(b"image_url"),
            utf8(b"description")
        ];

        let values = vector[
            utf8(b"MyNFT #{tokenId}"),
            utf8(b"MyNFT Collection"),
            utf8(b"ipfs://QmPbxeGcXhYQQNgsC6a36dDyYUcHgMLnGKnF8pVFmGsvqi"),
            utf8(b"This is My NFT")
        ];

        let publisher = package::claim(witness,ctx);
        // testnet: 0x79ba16f3383823d9c5ab81d5c9d9555332ade7fde534fc862617f68f350b9932
        let display = display::new_with_fields<MyNFT>(&publisher, keys, values, ctx);
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
        let nft = MyNFT {
            id: object::new(ctx),
            tokenId: state.count,
        };
        transfer::public_transfer(nft, sender);
    }

}
