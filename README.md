# Simple Compound-like Protocol

This document outlines the functionality of a simplified version of a Compound-like lending protocol implemented in Solidity.

## Contract Functions

### `deposit()`

Allows users to deposit Ether into the protocol. The deposited amount is added to the user's balance within the contract.

```solidity
function deposit() external payable;
