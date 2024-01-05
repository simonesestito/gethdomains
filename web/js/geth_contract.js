const geth_contract_address = "0x631BeE7107D4fAC081A608a03df5eA4C01EFf4Ab";
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
 		"inputs": [],
 		"name": "renounceOwnership",
 		"outputs": [],
 		"stateMutability": "nonpayable",
 		"type": "function"
 	},
 	{
 		"inputs": [
 			{
 				"internalType": "uint256",
 				"name": "ratio",
 				"type": "uint256"
 			}
 		],
 		"name": "setEtherToGeth",
 		"outputs": [],
 		"stateMutability": "nonpayable",
 		"type": "function"
 	},
 	{
 		"inputs": [
 			{
 				"internalType": "address",
 				"name": "op",
 				"type": "address"
 			}
 		],
 		"name": "setOperator",
 		"outputs": [],
 		"stateMutability": "nonpayable",
 		"type": "function"
 	},
 	{
 		"anonymous": false,
 		"inputs": [
 			{
 				"indexed": false,
 				"internalType": "uint256",
 				"name": "newRatio",
 				"type": "uint256"
 			}
 		],
 		"name": "SetRatio",
 		"type": "event"
 	},
 	{
 		"anonymous": false,
 		"inputs": [
 			{
 				"indexed": false,
 				"internalType": "address",
 				"name": "operator",
 				"type": "address"
 			}
 		],
 		"name": "SetSM",
 		"type": "event"
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
 				"internalType": "uint256",
 				"name": "amount",
 				"type": "uint256"
 			}
 		],
 		"name": "withdrawEther",
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

async function geth_getMyBalance() {
    const web3 = getWeb3();
    const user = await getCurrentUser();

    if (user === null) {
        return 0;
    }

    const contract = new web3.eth.Contract(abi, geth_contract_address);
    return contract.methods.balanceOf(user).call();
}

async function geth_purchaseTokens_fees(amount) {
    const web3 = getWeb3();
    const user = await getCurrentUser();

    if (user === null) {
        return 0;
    }

    const contract = new web3.eth.Contract(abi, geth_contract_address);
    const gas = await contract.methods.purchaseTokens().estimateGas({from: user, value: web3.utils.toWei(amount, "ether")});
    return gas.toString();
}

async function geth_purchaseTokens(amount) {
    const web3 = getWeb3();
    const user = await getCurrentUser();

    if (user === null) {
        return;
    }

    const contract = new web3.eth.Contract(abi, geth_contract_address);
    const gas = await contract.methods.purchaseTokens().estimateGas({from: user, value: web3.utils.toWei(amount, "ether")});
    await contract.methods.purchaseTokens().send({from: user, value: web3.utils.toWei(amount, "ether"), gas: gas});
}