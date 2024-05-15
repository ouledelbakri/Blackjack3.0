import React, { createContext, useState, useEffect } from 'react';
import Web3 from 'web3';
import getWeb3 from './getWeb3';
import loadContract from './loadContract';

export const Web3Context = createContext(null);

export const Web3Provider = ({ children }) => {
    const [web3, setWeb3] = useState(null);
    const [contracts, setContracts] = useState({});

    useEffect(() => {
        const initWeb3 = async () => {
            const web3 = await getWeb3(); 
            setWeb3(web3);
            const jetonCasino = await loadContract('JetonCasino', web3); // Charger le contrat JetonCasino
            const jeuBlackjack = await loadContract('JeuBlackjack', web3); // Charger le contrat JeuBlackjack
            setContracts({ jetonCasino, jeuBlackjack });
        };

        initWeb3();
    }, []);

    return (
        <Web3Context.Provider value={{ web3, contracts }}>
            {children}
        </Web3Context.Provider>
    );
};
