const JetonCasino = artifacts.require("JetonCasino");
const JeuBlackjack = artifacts.require("JeuBlackjack");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(JetonCasino, accounts[0]).then(function(jetonCasino) {
        return deployer.deploy(JeuBlackjack, jetonCasino.address);
    });
};
