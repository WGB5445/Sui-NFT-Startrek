module contract::test_publisher_2{
    use sui::tx_context::{Self, TxContext};
    use sui::package;

    struct TEST_PUBLISHER_2 has drop {}

    fun init(witness: TEST_PUBLISHER_2, ctx:&mut TxContext){
        // testnet: 0x6d97af493a81b775e6eefd2d9c8f298effc7793973491ef77b80464a6bb561aa
        package::claim_and_keep(witness,ctx);
    }

}
