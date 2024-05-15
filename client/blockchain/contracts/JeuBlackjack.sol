// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./JetonCasino.sol";

contract JeuBlackjack {
    JetonCasino public jetonCasino;
    uint256 public tokenPrice = 0.004 ether;
    address public owner;

    constructor(JetonCasino _jetonCasino) {
        jetonCasino = _jetonCasino;
        owner = msg.sender;
    }

    function buyTokens(uint256 amount) public payable {
    require(msg.value >= amount * tokenPrice, "Insufficient ETH sent");
    jetonCasino.mint(msg.sender, amount);
    jetonCasino.approve(address(this), jetonCasino.allowance(msg.sender, address(this)) + amount);
    (bool success, ) = payable(address(this)).call{value: msg.value}("");
    require(success, "Transfer failed.");
}
    function setAllowance(uint256 amount) public {
        jetonCasino.approve(address(this), amount);
    }

    function playBlackjack(uint256 betAmount) public {
        require(jetonCasino.allowance(msg.sender, address(this)) >= betAmount, "Bet exceeds allowance");
        require(jetonCasino.balanceOf(msg.sender) >= betAmount, "Insufficient balance");
        bool playerWins = (block.timestamp % 2) == 0; // Heads or tails
        if (playerWins) {
            jetonCasino.transfer(msg.sender, betAmount);
        } else {
            jetonCasino.transferFrom(msg.sender, address(this), betAmount);
        }
    }
function withdrawETH(uint256 tokenAmount) public {
        require(tokenAmount > 0, "Amount must be greater than zero");
        uint256 tokenBalance = jetonCasino.balanceOf(msg.sender);
        require(tokenBalance >= tokenAmount, "Insufficient token balance");

        
        uint256 ethAmount = tokenAmount * tokenPrice;

        // Vérifier si le contrat a suffisamment d'ETH
        require(address(this).balance >= ethAmount, "Insufficient ETH in contract");

        // Transférer les jetons du portefeuille de l'utilisateur au contrat
        jetonCasino.transferFrom(msg.sender, address(this), tokenAmount);

        // Envoyer l'ETH à l'utilisateur
        payable(msg.sender).transfer(ethAmount);
    }


    receive() external payable {}
}







