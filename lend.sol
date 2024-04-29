// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleCompoundLike {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public borrowBalances;

    uint256 public constant interestRatePerBlock = 1; // A simple fixed interest rate per block for demonstration

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function borrow(uint256 amount) external {
        uint256 maxBorrow = balances[msg.sender] * 50 / 100; // For example, you can borrow up to 50% of your deposited balance
        require(amount <= maxBorrow, "Borrow amount exceeds limit");
        borrowBalances[msg.sender] += amount;
        payable(msg.sender).transfer(amount);
    }

    function repay() external payable {
        uint256 owed = borrowBalances[msg.sender];
        require(msg.value >= owed, "Insufficient amount to repay");
        borrowBalances[msg.sender] = 0;
        // Any excess amount is considered as a deposit
        if (msg.value > owed) {
            balances[msg.sender] += msg.value - owed;
        }
    }

    function calculateInterest() public {
        // This function would be called periodically to update the borrow balances with interest
        // In a real-world scenario, this would involve a more complex interest rate model
        borrowBalances[msg.sender] += borrowBalances[msg.sender] * interestRatePerBlock / 10000;
    }
}
