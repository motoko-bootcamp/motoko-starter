# DoubleSpendIssue

This project demonstrates the double spend vulnerability as was presented during the Motoko Bootcamp of 2023. This code is vulnerable on purpose and should not be used in production.

The `SimpleLedger` canister mimicks a ledger but the only supported operations are to deposit tokens and view a balance. The tokens are created out of thin air in a sense that there is no transfer from another account. This is just for demo purposes and doesn't make sense.

The `DEX` canister holds balances for it's users. Users can get their funds refunded back to the SimpleLedger by calling the refund function. By calling refund multiple times in quick succession, someone can transfer the same balance on the DEX multiple times to the SimpleLedger. Thereby creating new tokens.

To initialize the balance of the user on the DEX, an `init_account` function is available. To retrieve the local and ledger balance, two getter functions are available.

Check out the Motoko lecture for more information and to learn how to exploit and mitigate the vulnerabilities present in this code. Have fun!