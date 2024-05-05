# Ocean Token Module

## Overview

Introducing Ocean Token, an asset designed for the next generation of Web3 Wallets - Wave Wallet. As the digital economy flourishes, Ocean Token serves as a powerful role within Wave Wallet, seamlessly integrating necessary features to navigate blockchain complexities. This module utilizes Sui-specific features like treasury management, and provide a controlled environment for token operations including minting, transferring, and burning of tokens.

## Features

- **Token Initialization**: Initialize the token with a metadata icon and predefined capabilities.
- **Minting**: Authorized minting of Ocean tokens based on treasury capabilities.
- **Burning**: Secure burning of tokens to manage supply.
- **Account Blocking**: Prevent specific accounts from accessing or using the token through deny lists.
- **Account Unblocking**: Removal of accounts from the deny list to restore access.
- **Treasury and Deny Cap Transfers**: Facilitate the transfer of administrative capabilities to other addresses.

## Usage

### Initialization

Tokens are initialized by invoking the `init` function, which sets up the necessary components such as treasury and deny capabilities, along with an associated metadata object.

```move
init(witness: OCEAN, ctx: &mut TxContext)
```

### Minting Tokens
Tokens can be minted to specified recipients by authorized entities holding treasury capabilities.

```move
mint(treasury_cap: &mut TreasuryCap<OCEAN>, amount: u64, ctx: &mut TxContext)
```

### Burning Tokens
Tokens can be securely destroyed to manage overall supply.

```move
burn(treasury_cap: &mut TreasuryCap<OCEAN>, coin: Coin<OCEAN>)
```

### Managing Access
Block or unblock accounts from using the token using deny lists.

```move
block_account(deny_list: &mut DenyList, deny_cap: &mut DenyCap<OCEAN>, account: address, ctx: &mut TxContext)
unblock_account(deny_list: &mut DenyList, deny_cap: &mut DenyCap<OCEAN>, account: address, ctx: &mut TxContext)
```

### Transferring Capabilities
Transfer treasury or deny capabilities to different addresses.

```move
transfer_treasury_cap(treasury_cap: TreasuryCap<OCEAN>, recipient: address)
transfer_deny_cap(deny_cap: DenyCap<OCEAN>, recipient: address)
```
### Contribution
Contributions to the Ocean Token module are welcome. Please ensure that your contributions adhere to the Sui guidelines for security and code quality.
