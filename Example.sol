// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Example {
    address private owner;
    uint256 private amountForClaim;
    uint256 private favouriteNumber;

    error NotOwner();
    error NotEnoughEth();

    constructor() {
        owner = msg.sender;
    }

    function claimOwnership() public payable {
        if (msg.value <= amountForClaim) { revert NotEnoughEth(); }
        amountForClaim = msg.value;
        owner = msg.sender;
        // Not checking return value to avoid dos
        owner.call{value: msg.value}("");
    }

    function setFavouriteNumber(uint256 number) public {
        if (msg.sender != owner) { revert NotOwner(); }
        favouriteNumber = number;
    }

    function getFavouriteNumber() public view returns (uint256) {
        return favouriteNumber;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}