import TrieMap "mo:base/TrieMap";
import Account "account";
actor MotoCoin {
    public type Account = Account.Account;

    let ledger : TrieMap.TrieMap<Account, Nat> = TrieMap.TrieMap<Account, Nat>(Account.accountsEqual, Account.accountsHash);

    
}