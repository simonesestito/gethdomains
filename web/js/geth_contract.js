const geth_contract_address = "0xa514C64fd0e5Fe44B2C4448AfB8C6f3268232169";
const abi = [
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "spender",
            				"type": "address"
            			},
            			{
            				"internalType": "uint256",
            				"name": "value",
            				"type": "uint256"
            			}
            		],
            		"name": "approve",
            		"outputs": [
            			{
            				"internalType": "bool",
            				"name": "",
            				"type": "bool"
            			}
            		],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "destroy",
            		"outputs": [],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"stateMutability": "nonpayable",
            		"type": "constructor"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "spender",
            				"type": "address"
            			},
            			{
            				"internalType": "uint256",
            				"name": "allowance",
            				"type": "uint256"
            			},
            			{
            				"internalType": "uint256",
            				"name": "needed",
            				"type": "uint256"
            			}
            		],
            		"name": "ERC20InsufficientAllowance",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "sender",
            				"type": "address"
            			},
            			{
            				"internalType": "uint256",
            				"name": "balance",
            				"type": "uint256"
            			},
            			{
            				"internalType": "uint256",
            				"name": "needed",
            				"type": "uint256"
            			}
            		],
            		"name": "ERC20InsufficientBalance",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "approver",
            				"type": "address"
            			}
            		],
            		"name": "ERC20InvalidApprover",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "receiver",
            				"type": "address"
            			}
            		],
            		"name": "ERC20InvalidReceiver",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "sender",
            				"type": "address"
            			}
            		],
            		"name": "ERC20InvalidSender",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "spender",
            				"type": "address"
            			}
            		],
            		"name": "ERC20InvalidSpender",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "owner",
            				"type": "address"
            			}
            		],
            		"name": "OwnableInvalidOwner",
            		"type": "error"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "account",
            				"type": "address"
            			}
            		],
            		"name": "OwnableUnauthorizedAccount",
            		"type": "error"
            	},
            	{
            		"anonymous": false,
            		"inputs": [
            			{
            				"indexed": true,
            				"internalType": "address",
            				"name": "owner",
            				"type": "address"
            			},
            			{
            				"indexed": true,
            				"internalType": "address",
            				"name": "spender",
            				"type": "address"
            			},
            			{
            				"indexed": false,
            				"internalType": "uint256",
            				"name": "value",
            				"type": "uint256"
            			}
            		],
            		"name": "Approval",
            		"type": "event"
            	},
            	{
            		"anonymous": false,
            		"inputs": [
            			{
            				"indexed": true,
            				"internalType": "address",
            				"name": "previousOwner",
            				"type": "address"
            			},
            			{
            				"indexed": true,
            				"internalType": "address",
            				"name": "newOwner",
            				"type": "address"
            			}
            		],
            		"name": "OwnershipTransferred",
            		"type": "event"
            	},
            	{
            		"inputs": [],
            		"name": "purchaseTokens",
            		"outputs": [],
            		"stateMutability": "payable",
            		"type": "function"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "uint256",
            				"name": "tokenAmount",
            				"type": "uint256"
            			}
            		],
            		"name": "purchaseWei",
            		"outputs": [],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "renounceOwnership",
            		"outputs": [],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "newOperator",
            				"type": "address"
            			}
            		],
            		"name": "setOperator",
            		"outputs": [],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "to",
            				"type": "address"
            			},
            			{
            				"internalType": "uint256",
            				"name": "value",
            				"type": "uint256"
            			}
            		],
            		"name": "transfer",
            		"outputs": [
            			{
            				"internalType": "bool",
            				"name": "",
            				"type": "bool"
            			}
            		],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"anonymous": false,
            		"inputs": [
            			{
            				"indexed": true,
            				"internalType": "address",
            				"name": "from",
            				"type": "address"
            			},
            			{
            				"indexed": true,
            				"internalType": "address",
            				"name": "to",
            				"type": "address"
            			},
            			{
            				"indexed": false,
            				"internalType": "uint256",
            				"name": "value",
            				"type": "uint256"
            			}
            		],
            		"name": "Transfer",
            		"type": "event"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "from",
            				"type": "address"
            			},
            			{
            				"internalType": "address",
            				"name": "to",
            				"type": "address"
            			},
            			{
            				"internalType": "uint256",
            				"name": "value",
            				"type": "uint256"
            			}
            		],
            		"name": "transferFrom",
            		"outputs": [
            			{
            				"internalType": "bool",
            				"name": "",
            				"type": "bool"
            			}
            		],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "newOwner",
            				"type": "address"
            			}
            		],
            		"name": "transferOwnership",
            		"outputs": [],
            		"stateMutability": "nonpayable",
            		"type": "function"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "owner",
            				"type": "address"
            			},
            			{
            				"internalType": "address",
            				"name": "spender",
            				"type": "address"
            			}
            		],
            		"name": "allowance",
            		"outputs": [
            			{
            				"internalType": "uint256",
            				"name": "",
            				"type": "uint256"
            			}
            		],
            		"stateMutability": "view",
            		"type": "function"
            	},
            	{
            		"inputs": [
            			{
            				"internalType": "address",
            				"name": "account",
            				"type": "address"
            			}
            		],
            		"name": "balanceOf",
            		"outputs": [
            			{
            				"internalType": "uint256",
            				"name": "",
            				"type": "uint256"
            			}
            		],
            		"stateMutability": "view",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "decimals",
            		"outputs": [
            			{
            				"internalType": "uint8",
            				"name": "",
            				"type": "uint8"
            			}
            		],
            		"stateMutability": "pure",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "name",
            		"outputs": [
            			{
            				"internalType": "string",
            				"name": "",
            				"type": "string"
            			}
            		],
            		"stateMutability": "view",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "owner",
            		"outputs": [
            			{
            				"internalType": "address",
            				"name": "",
            				"type": "address"
            			}
            		],
            		"stateMutability": "view",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "symbol",
            		"outputs": [
            			{
            				"internalType": "string",
            				"name": "",
            				"type": "string"
            			}
            		],
            		"stateMutability": "view",
            		"type": "function"
            	},
            	{
            		"inputs": [],
            		"name": "totalSupply",
            		"outputs": [
            			{
            				"internalType": "uint256",
            				"name": "",
            				"type": "uint256"
            			}
            		],
            		"stateMutability": "view",
            		"type": "function"
            	}
            ];

async function _initializeGethContract() {
    const web3 = getWeb3();
    const user = await getCurrentUser();

    if (user === null) {
        return;
    }

    const contract = new web3.eth.Contract(abi, geth_contract_address);

    return [contract, user];
}

async function geth_getMyBalance() {
    const [contract, user] = await _initializeGethContract();
    return contract.methods.balanceOf(user).call();
}

async function geth_purchaseTokens_fees(amount) {
    const [contract, user] = await _initializeGethContract();
    const gas = await contract.methods.purchaseTokens().estimateGas({from: user, value: web3.utils.toWei(amount, "ether")});
    return gas.toString();
}

async function geth_purchaseTokens(amount) {
    const [contract, user] = await _initializeGethContract();
    const weiAmount = web3.utils.toWei(amount, "ether").slice(0, -3); // Equivalent as /1000
    const gas = await contract.methods.purchaseTokens().estimateGas({from: user, value: weiAmount});

    const txHash = await wrapContractSend(contract.methods.purchaseTokens()
        .send({from: user, value: weiAmount, gas: gas}));

    // Add token to Metamask if not already present
    const alreadyAdded = localStorage.getItem('geth_token_added');
    if (ethereum && ethereum.request && !alreadyAdded) {
        ethereum.request({
            method: 'wallet_watchAsset',
            params: {
                type: 'ERC20',
                options: {
                    address: geth_contract_address, // The address that the token is at.
                    symbol: 'GETH', // A ticker symbol or shorthand, up to 5 chars.
                    decimals: 0, // The number of decimals in the token
                    image: window.location.origin + '/big_icon.png', // A string url of the token logo
                },
            },
        }).then(() => {
            // Successfully added token to Metamask
            // Save not to ask again
            localStorage.setItem('geth_token_added', 'true');
        });
    }

    return txHash;
}

async function geth_withdrawEther_fees(amount) {
    const [contract, user] = await _initializeGethContract();
    const gas = await contract.methods.purchaseWei(amount).estimateGas({from: user});
    return gas.toString();
}

async function geth_withdrawEther(amount) {
    const [contract, user] = await _initializeGethContract();
    const gas = await contract.methods.purchaseWei(amount).estimateGas({from: user});
    return wrapContractSend(contract.methods.purchaseWei(amount).send({from: user, gas: gas}));
}

let token_sent_event_emitter = null;
let token_received_event_emitter = null;
async function _initTokenEvents() {
    if (token_sent_event_emitter !== null) {
        token_sent_event_emitter.removeAllListeners('data');
        token_sent_event_emitter.removeAllListeners('error');
    }
    if (token_received_event_emitter !== null) {
        token_received_event_emitter.removeAllListeners('data');
        token_received_event_emitter.removeAllListeners('error');
    }

    const [contract, user] = await _initializeGethContract();
    if (user === null) {
        return;
    }

    // Subscribe to Transfer events from or to ANYONE
    // Anyone is required to make the domain search reactive
    const _onEvent = function(event) {
         console.log(event);
         web3EventsSink('coinTransfer', JSON.stringify({
             from: event.returnValues.from,
             to: event.returnValues.to,
             value: event.returnValues.value,
         }));
     };
    const _onError = function(error) {
        console.error(error);
        web3ErrorsSink(error.code, error.data.reason);
    };
    token_sent_event_emitter = contract.events.Transfer().on('data', _onEvent).on('error', _onError);
    token_received_event_emitter = contract.events.Transfer().on('data', _onEvent).on('error', _onError);
}
_initTokenEvents().catch(console.error);