# FundMe

**FundMe** is a smart contract that allows users to send and withdraw Ether (ETH). This repository includes the Solidity contract, accompanying scripts, and test cases to simulate various scenarios, including VM pranks and edge cases.

## Features

- **Send Ether**: Users can fund the contract with ETH.
- **Withdraw Ether**: The contract owner can withdraw ETH.
- **Testing**: Includes a suite of tests to validate contract functionality.
- **VM Pranks**: Tests leverage `vm.prank()` to simulate interactions from different addresses, ensuring robust contract behavior.

## Contract: `FundMe.sol`

### Key Functions

- **`fund()`**:  
   Allows users to send Ether to the contract.

- **`withdraw()`**:  
   Allows the owner to withdraw all funds from the contract.

- **`getFunders()`**:  
   Returns a list of addresses that have funded the contract.

- **`getBalance()`**:  
   Returns the current balance of the contract.

## Repository Structure

```bash
.
├── lib                     # External libraries (if any)
├── node_modules             # Dependencies
├── script                   # Deployment scripts and helper scripts
├── src                      # Solidity source files
├── test                     # Solidity and/or JavaScript test files
├── .github/workflows        # GitHub Actions workflows (CI/CD)
├── .gitignore               # Ignore specific files in git
├── README.md                # Project documentation
├── foundry.toml             # Foundry project configuration
├── promise.md               # Additional information
