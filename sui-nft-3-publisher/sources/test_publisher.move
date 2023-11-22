module contract::test_publisher{
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::package;

    struct TEST_PUBLISHER has drop {}

    fun init(witness: TEST_PUBLISHER, ctx:&mut TxContext){
        // testnet: 0x2b8ff0eaf17ec9c3a10d9c415a82ae748580d7e12d703d02e203bbf7052771ca
        let publisher = package::claim(witness,ctx);
        transfer::public_transfer(publisher, tx_context::sender(ctx));
    }

}
