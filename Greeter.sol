// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Greeter {
    string greeting;
    address public owner;

    constructor(string memory _greeting) {
        greeting = _greeting;
        owner = msg.sender;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreet(string memory _greeting) public {
        require(msg.sender == owner);
        greeting = _greeting;
    }
}

