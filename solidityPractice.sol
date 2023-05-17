// SPDX-License-Identifier: GPL-3.0
// hello this is my first time writing a solidity code by myself. 
// this is in here for a project on making a smart contract. 
// this smart contract should be able to make all or none transactions.
pragma solidity >= 0.8.0 < 0.90;

contract FirstContract{
    //let's discuss what all do i need in the smart contract 
    // two deposit and withdrawal functions
    //a mapping to store deposits 
    // a mapping to check whether the withdrawer is a depositor or not
    // one modifier for access restrictions
     
    mapping (address => uint256) public deposits;
    mapping (address => bool) public depositors;

    modifier onlyDepositor() {
    require(depositors[msg.sender], "You are not a depositor, so you cannot call this function");
    _;
}

   function deposit() public payable {
    require(msg.value > 0, "Deposit amount must be greater than zero");
    uint256 amount = msg.value;
    deposits[msg.sender] += amount;
    depositors[msg.sender] = true;
}
    
    function withdrawal() public  onlyDepositor{
        uint256 amount = deposits[msg.sender];
        require(amount >0, "Insufficient funds");
        deposits[msg.sender] = 0;
        payable (msg.sender).transfer(amount);
    }

}