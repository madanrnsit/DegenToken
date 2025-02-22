// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function burn(uint256 burn_amt) public override {
        require(balanceOf(msg.sender) >= burn_amt, "Insufficient Balance");
        _burn(msg.sender, burn_amt);
    }

    function redeem(uint256 action) public {
        require(action >= 1 && action <= 3, "Invalid action");

        if (balanceOf(msg.sender) < 50) {
            revert("Insufficient Balance");
        }
        if (action == 1) {
            _mint(msg.sender, 10);
        } else if (action == 2) {
            require(balanceOf(msg.sender) >= 10, "Insufficient Tokens for T-shirt");
            _burn(msg.sender, 10);
            emit TShirtRedeemed("You redeemed a T-Shirt");
        } else {
             _burn(msg.sender,10);
             emit SpecialActionExecuted("Special Price");
        } 
    }

    function customMint(uint256 baseAmount, uint256 bonusPercentage) public {
        uint256 bonusAmount = (baseAmount * bonusPercentage) / 100;
        uint256 totalMintAmount = baseAmount + bonusAmount;

        _mint(msg.sender, totalMintAmount);
    }

    event TShirtRedeemed(string message);
    event SpecialActionExecuted(string message);

    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
