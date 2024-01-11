function getWeb3() {
    if (window.appWeb3 === undefined) {
        window.appWeb3 = new Web3(window.ethereum || "ws://localhost:7545");
        window.web3 = window.appWeb3;
    }

    return window.appWeb3;
}

async function isSepoliaNetwork() {
    const web3 = getWeb3();
    const networkId = await web3.eth.net.getId();
    return networkId === 0xaa36a7;
}

async function useSepoliaNetwork() {
    if (await isSepoliaNetwork()) {
        return;
    }

    const web3 = getWeb3();
    if (web3.currentProvider.request) {
        await web3.currentProvider.request({
            method: 'wallet_switchEthereumChain',
            params: [{chainId: '0xaa36a7'}]
        });
    }

    return isSepoliaNetwork();
}

async function getCurrentUser() {
    const web3 = getWeb3();

    const accounts = await web3.eth.getAccounts();
    if (accounts.length === 0) {
        return null;
    }

    return accounts[0];
}

async function canLogin() {
    const web3 = getWeb3();

    try {
        await web3.eth.net.isListening();
        return true;
    } catch (e) {
        return false;
    }
}

async function login() {
    const web3 = getWeb3();

    if (web3.currentProvider.request) {
        await web3.currentProvider.request({
            method: 'wallet_requestPermissions',
            params: [
                {
                    'eth_accounts': {}
                }
            ]
        });
    }

    _initDomainsEvents();
    _initTokenEvents();

    return getCurrentUser();
}

async function wrapContractSend(originalSend) {
    // Return as soon as the transactionHash is ready
    return new Promise((resolve, reject) => {
        let txHash = null;

        originalSend.once('transactionHash', function(hash) {
                console.log('Transaction Hash:', hash);
                txHash = hash;
                resolve(hash);
            })
            .on('error', function(error) {
                console.log('Error:', error);
                if (txHash === null) {
                    reject(error);
                } else {
                    // Use events
                    const reason = error.data && error.data.reason ? error.data.reason : error.message;
                    web3ErrorsSink(error.code, reason);
                }
            })
            .then(function(receipt) {
                // will be fired once the receipt is mined
                console.log('Receipt mined!', receipt);
            });
    });
}