// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Bank{
    uint public contractBalance =0;
    mapping (address => uint) balance;
    mapping(address=>uint) depositTimestamps;

// Function for adding money in contract 
    
    function addMoney() public payable{
        balance[msg.sender]=msg.value;
        contractBalance=contractBalance+msg.value;
        depositTimestamps[msg.sender] = block.timestamp; 
}

    function getBalance(address userAddress) public view returns (uint){
       uint principal = balance[userAddress];
       uint time = block.timestamp - depositTimestamps[userAddress];
       return principal + uint((principal * 7 * time) / (100 * 365 * 24 * 60 * 60)) + 1;
    }
    
    function withdraw () public payable{
     address payable withdrawTo = payable (msg.sender);
     uint amount = getBalance(msg.sender);
     withdrawTo.transfer(amount);
     contractBalance -=amount;
     balance[msg.sender]=0;
    }
    function addMoneyToContract() public payable {
        contractBalance += msg.value;
    }

}
