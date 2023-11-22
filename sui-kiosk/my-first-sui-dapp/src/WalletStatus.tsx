import {
  useCurrentAccount,
  useSignAndExecuteTransactionBlock,
} from "@mysten/dapp-kit";
import { Container, Flex, Heading, Text } from "@radix-ui/themes";
import { OwnedObjects } from "./OwnedObjects";
import { TransactionBlock } from "@mysten/sui.js/transactions";

export function WalletStatus() {
  const account = useCurrentAccount();
  const { mutate: signAndExecuteTransactionBlock } =
    useSignAndExecuteTransactionBlock();
  return (
    <Container my="2">
      <Heading mb="2">Wallet Status</Heading>

      {account ? (
        <Flex direction="column">
          <Text>Wallet connected</Text>
          <Text>Address: {account.address}</Text>
          <button
            onClick={async () => {
              signAndExecuteTransactionBlock(
                {
                  transactionBlock: new TransactionBlock(),
                  chain: "sui:testnet",
                },
                {
                  onSuccess: (result) => {
                    console.log("executed transaction block", result);
                  },
                },
              );
            }}
          >
            Merge
          </button>
        </Flex>
      ) : (
        <Text>Wallet not connected</Text>
      )}
      <OwnedObjects />
    </Container>
  );
}
