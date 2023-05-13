import Account "account";
import TrieMap "mo:base/TrieMap";
actor MotoCoin {

    type Account = Account.Account;

    let trie = TrieMap.TrieMap<Account, Nat>(Account.accountsEqual, Account.accountsHash);
};