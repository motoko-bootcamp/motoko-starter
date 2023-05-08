
# Create Post

```
dfx canister call crud createPost '(
    record {
        userPrincipal = principal "'$(dfx identity get-principal)'";
        title = "Why fully on-chain is so important?";
        description = "No manipulation, no cloud, no BS.";
    }
)'
```

# Read Post by Id

```
dfx canister call crud readPost '(0)'
```

# Read All Posts

```
dfx canister call crud readAllPosts
```

# Update Post

Success
```
dfx canister call crud updatePost '(
    record {
        userPrincipal = principal "'$(dfx identity get-principal)'";
        title = "Why fully on-chain is so important?";
        description = "No BS.";
    },
    0
)'
```

Post not found.
```
dfx canister call crud updatePost '(
    record {
        userPrincipal = principal "'$(dfx identity get-principal)'";
        title = "Why fully on-chain is so important?";
        description = "No manipulation, no cloud, no BS.";
    },
    1
)'
```

# Remove Post by Id

```
dfx canister call crud removePost '(0)'
```
