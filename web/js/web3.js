function getWeb3() {
    if (window.appWeb3 === undefined) {
        window.appWeb3 = new Web3(window.ethereum || "ws://localhost:7545");
        window.web3 = window.appWeb3;
    }

    return window.appWeb3;
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

    return getCurrentUser();
}