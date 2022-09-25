// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Token {
    mapping (address => uint256) public balanceOf;
    address owner;

    event Transfer(address _sender, address _recipient, uint256 _amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be owner!");
        _;
    }

    constructor(uint256 initialSupply) {
        balanceOf[msg.sender] = initialSupply;
        owner = msg.sender;
    }

    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value, "Insufficient funds!");
        require(balanceOf[_to] + _value > balanceOf[_to], "Recipient balance overflow!");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
    }

    function add(uint256 _value) public onlyOwner {
        require(balanceOf[owner] + _value > balanceOf[owner], "Owner balance overflow!");
        balanceOf[owner] += _value;
    }
}

