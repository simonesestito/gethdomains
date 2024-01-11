const geth_domains_address = "0xCe16845f4adc57BDCadb1f5b2B32a1b65f9d414E";
const geth_domains_abi = [
                         	{
                         		"inputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "constructor"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "numerator",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "uint256",
                         				"name": "denominator",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "ERC2981InvalidDefaultRoyalty",
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
                         		"name": "ERC2981InvalidDefaultRoyaltyReceiver",
                         		"type": "error"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "uint256",
                         				"name": "numerator",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "uint256",
                         				"name": "denominator",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "ERC2981InvalidTokenRoyalty",
                         		"type": "error"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "address",
                         				"name": "receiver",
                         				"type": "address"
                         			}
                         		],
                         		"name": "ERC2981InvalidTokenRoyaltyReceiver",
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
                         				"name": "tokenId",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "address",
                         				"name": "owner",
                         				"type": "address"
                         			}
                         		],
                         		"name": "ERC721IncorrectOwner",
                         		"type": "error"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "address",
                         				"name": "operator",
                         				"type": "address"
                         			},
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "ERC721InsufficientApproval",
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
                         		"name": "ERC721InvalidApprover",
                         		"type": "error"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "address",
                         				"name": "operator",
                         				"type": "address"
                         			}
                         		],
                         		"name": "ERC721InvalidOperator",
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
                         		"name": "ERC721InvalidOwner",
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
                         		"name": "ERC721InvalidReceiver",
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
                         		"name": "ERC721InvalidSender",
                         		"type": "error"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "ERC721NonexistentToken",
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
                         				"name": "approved",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "uint256",
                         				"name": "tokenId",
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
                         				"name": "owner",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "operator",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": false,
                         				"internalType": "bool",
                         				"name": "approved",
                         				"type": "bool"
                         			}
                         		],
                         		"name": "ApprovalForAll",
                         		"type": "event"
                         	},
                         	{
                         		"anonymous": false,
                         		"inputs": [
                         			{
                         				"indexed": true,
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "seller",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": false,
                         				"internalType": "uint256",
                         				"name": "price",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "DomainForSale",
                         		"type": "event"
                         	},
                         	{
                         		"anonymous": false,
                         		"inputs": [
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "buyer",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "DomainSold",
                         		"type": "event"
                         	},
                         	{
                         		"anonymous": false,
                         		"inputs": [
                         			{
                         				"indexed": true,
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "owner",
                         				"type": "address"
                         			}
                         		],
                         		"name": "IpfsOverwritten",
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
                         		"anonymous": false,
                         		"inputs": [
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "originalOwner",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "buyer",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"indexed": false,
                         				"internalType": "uint256",
                         				"name": "royaltiesAmount",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "RoyaltiesPaid",
                         		"type": "event"
                         	},
                         	{
                         		"anonymous": false,
                         		"inputs": [
                         			{
                         				"indexed": true,
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "owner",
                         				"type": "address"
                         			}
                         		],
                         		"name": "TorOverwritten",
                         		"type": "event"
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
                         				"indexed": true,
                         				"internalType": "uint256",
                         				"name": "tokenId",
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
                         				"name": "to",
                         				"type": "address"
                         			},
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "approve",
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
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "domains",
                         		"outputs": [
                         			{
                         				"internalType": "uint32",
                         				"name": "price",
                         				"type": "uint32"
                         			},
                         			{
                         				"internalType": "uint32",
                         				"name": "resoldTimes",
                         				"type": "uint32"
                         			},
                         			{
                         				"internalType": "bytes",
                         				"name": "dominioTorOrIpfs",
                         				"type": "bytes"
                         			},
                         			{
                         				"internalType": "bool",
                         				"name": "isTor",
                         				"type": "bool"
                         			}
                         		],
                         		"stateMutability": "view",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "id",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "findDomainById",
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
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "getApproved",
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
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "getId",
                         		"outputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "id",
                         				"type": "uint256"
                         			}
                         		],
                         		"stateMutability": "pure",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [],
                         		"name": "getMyDomainIndexes",
                         		"outputs": [
                         			{
                         				"internalType": "uint256[]",
                         				"name": "",
                         				"type": "uint256[]"
                         			}
                         		],
                         		"stateMutability": "view",
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
                         				"name": "operator",
                         				"type": "address"
                         			}
                         		],
                         		"name": "isApprovedForAll",
                         		"outputs": [
                         			{
                         				"internalType": "bool",
                         				"name": "",
                         				"type": "bool"
                         			}
                         		],
                         		"stateMutability": "view",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "keys",
                         		"outputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "",
                         				"type": "bytes"
                         			}
                         		],
                         		"stateMutability": "view",
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
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "ownerOf",
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
                         		"name": "prezzoBase",
                         		"outputs": [
                         			{
                         				"internalType": "uint32",
                         				"name": "",
                         				"type": "uint32"
                         			}
                         		],
                         		"stateMutability": "view",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "purchaseExistingDomain",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"internalType": "bytes",
                         				"name": "torOrIpfs",
                         				"type": "bytes"
                         			},
                         			{
                         				"internalType": "bool",
                         				"name": "isTor",
                         				"type": "bool"
                         			}
                         		],
                         		"name": "purchaseNewDomain",
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
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "retrieveDomain",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "uint256",
                         				"name": "salePrice",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "royaltyInfo",
                         		"outputs": [
                         			{
                         				"internalType": "address",
                         				"name": "",
                         				"type": "address"
                         			},
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
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "safeTransferFrom",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
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
                         				"name": "tokenId",
                         				"type": "uint256"
                         			},
                         			{
                         				"internalType": "bytes",
                         				"name": "data",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "safeTransferFrom",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"internalType": "uint32",
                         				"name": "price",
                         				"type": "uint32"
                         			}
                         		],
                         		"name": "sellDomain",
                         		"outputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "prezzo",
                         				"type": "uint256"
                         			}
                         		],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "address",
                         				"name": "operator",
                         				"type": "address"
                         			},
                         			{
                         				"internalType": "bool",
                         				"name": "approved",
                         				"type": "bool"
                         			}
                         		],
                         		"name": "setApprovalForAll",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"internalType": "bytes",
                         				"name": "dominioIpfs",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "setIpfs",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "uint32",
                         				"name": "prezzo",
                         				"type": "uint32"
                         			}
                         		],
                         		"name": "setPrezzoBase",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "domain",
                         				"type": "bytes"
                         			},
                         			{
                         				"internalType": "bytes",
                         				"name": "dominioTor",
                         				"type": "bytes"
                         			}
                         		],
                         		"name": "setTor",
                         		"outputs": [],
                         		"stateMutability": "nonpayable",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "bytes4",
                         				"name": "interfaceId",
                         				"type": "bytes4"
                         			}
                         		],
                         		"name": "supportsInterface",
                         		"outputs": [
                         			{
                         				"internalType": "bool",
                         				"name": "",
                         				"type": "bool"
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
                         		"inputs": [
                         			{
                         				"internalType": "uint256",
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "tokenURI",
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
                         				"name": "tokenId",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "transferFrom",
                         		"outputs": [],
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
                         	}
                         ];

async function _initializeGethDomainsContract() {
    const web3 = getWeb3();
    const user = await getCurrentUser();

    if (user === null) {
        return;
    }

    const contract = new web3.eth.Contract(geth_domains_abi, geth_domains_address);

    return [contract, user];
}

/**
 * Receive a buffer, but it's given as a Base64 string.
 * @param {string} base64
 * @returns {string} Hex bytes
 */
function _receiveBytes(base64) {
    console.log('Received base64:', base64);

    const binaryString = atob(base64);
    const bytes = new Uint8Array(binaryString.length);
    for (let i = 0; i < binaryString.length; i++) {
        bytes[i] = binaryString.charCodeAt(i);
    }

    // Now, make bytes an hex string
    let hexString = '0x';
    for (let i = 0; i < bytes.length; i++) {
        hexString += bytes[i].toString(16).padStart(2, '0');
    }
    console.log('Transformed into hex:', hexString);
    return hexString;
}


async function domains_purchaseNewDomain_fees(domain, pointedAddress, domainType) {
    domain = _receiveBytes(domain);
    pointedAddress = _receiveBytes(pointedAddress);
    const [contract, user] = await _initializeGethDomainsContract();
    const isTor = domainType === 'tor';
    const gas = await contract.methods.purchaseNewDomain(
        domain,
        pointedAddress,
        isTor
    ).estimateGas({from: user});
    return gas.toString();
}

async function domains_purchaseNewDomain(domain, pointedAddress, domainType) {
    domain = _receiveBytes(domain);
    pointedAddress = _receiveBytes(pointedAddress);
    const [contract, user] = await _initializeGethDomainsContract();
    const isTor = domainType === 'tor';
        const gas = await contract.methods.purchaseNewDomain(
            domain,
            pointedAddress,
            isTor
        ).estimateGas({from: user});

    const txHash = await wrapContractSend(contract.methods.purchaseNewDomain(
                                                      domain,
                                                      pointedAddress,
                                                      isTor
                                                  ).send({from: user, gas: gas}));

    return txHash;
}


async function domains_searchDomain(domain) {
    domain = _receiveBytes(domain);
    const [contract, user] = await _initializeGethDomainsContract();
    const result = await contract.methods.domains(domain).call({from: user});
    if (result.dominioTorOrIpfs == null) {
        // Result not found.
        return null;
    }
    const domainId = await contract.methods.getId(domain).call({from: user});
    const owner = await contract.methods.ownerOf(domainId).call({from: user});
    return JSON.stringify({
        price: result.price,
        resoldTimes: result.resoldTimes,
        pointedAddress: result.dominioTorOrIpfs,
        isTor: result.isTor,
        owner: owner,
    });
}


async function domains_getMyDomains() {
    const [contract, user] = await _initializeGethDomainsContract();
    const indexes = await contract.methods.getMyDomainIndexes().call({from: user});
    const result = [];
    for (const index of indexes) {
        const domainBytes = await contract.methods.keys(index).call({from: user});
        const domain = await contract.methods.domains(domainBytes).call({from: user});
        result.push({
            domain: domainBytes,
            price: domain.price,
            resoldTimes: domain.resoldTimes,
            pointedAddress: domain.dominioTorOrIpfs,
            isTor: domain.isTor,
            owner: user,
        });
    }

    return JSON.stringify(result);
}

async function domains_addDomainToMetamask(domainBytes) {
    domainBytes = _receiveBytes(domainBytes);
    const [contract, user] = await _initializeGethDomainsContract();
    const domainId = await contract.methods.getId(domainBytes).call({from: user});
    if (window.ethereum && ethereum.request) {
        ethereum.request({
            method: 'wallet_watchAsset',
            params: {
                type: 'ERC721',
                options: {
                    address: geth_domains_address, // The address that the token is at.
                    tokenId: domainId,
                },
            },
        });
    }
}


let domains_sent_event_emitter = null;
let domains_received_event_emitter = null;
async function _initDomainsEvents() {
    if (domains_sent_event_emitter !== null) {
        domains_sent_event_emitter.removeAllListeners('data');
        domains_sent_event_emitter.removeAllListeners('error');
    }
    if (domains_received_event_emitter !== null) {
        domains_received_event_emitter.removeAllListeners('data');
        domains_received_event_emitter.removeAllListeners('error');
    }

    const [contract, user] = await _initializeGethDomainsContract();
    if (user === null) {
        return;
    }

    // Subscribe to Transfer events from or to me
    const _onEvent = async function(event) {
        console.log(event);
         const tokenId = event.returnValues.tokenId;
         const domainIndex = await contract.methods.findDomainById(tokenId).call({from: user});
         const domainBytes = await contract.methods.keys(domainIndex).call({from: user});
         web3EventsSink('domainTransfer', JSON.stringify({
             from: event.returnValues.from,
             to: event.returnValues.to,
             domainBytes: domainBytes,
         }));
    };
    const _onError = async function(error) {
        console.error(error);
        web3ErrorsSink(error.code, error.data.reason);
    };

    domains_sent_event_emitter = contract.events.Transfer({filter: {from: user}}).on('data', _onEvent).on('error', _onError);
    domains_received_event_emitter = contract.events.Transfer({filter: {to: user}}).on('data', _onEvent).on('error', _onError);
}
_initDomainsEvents().catch(console.error);