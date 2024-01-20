const geth_domains_address = "0x8FC6C7eF9a2ec6df5f90b76C011C7E7Ee33E512f";
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
                         				"indexed": false,
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
                         				"indexed": false,
                         				"internalType": "address",
                         				"name": "seller",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": true,
                         				"internalType": "address",
                         				"name": "buyer",
                         				"type": "address"
                         			},
                         			{
                         				"indexed": false,
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
                         				"indexed": false,
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
                         				"indexed": false,
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
                         				"indexed": false,
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
                         				"name": "pointedAddress",
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
                         				"internalType": "uint256",
                         				"name": "id",
                         				"type": "uint256"
                         			}
                         		],
                         		"name": "getDomainById",
                         		"outputs": [
                         			{
                         				"internalType": "bytes",
                         				"name": "",
                         				"type": "bytes"
                         			},
                         			{
                         				"components": [
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
                         						"name": "pointedAddress",
                         						"type": "bytes"
                         					},
                         					{
                         						"internalType": "bool",
                         						"name": "isTor",
                         						"type": "bool"
                         					}
                         				],
                         				"internalType": "struct Domain",
                         				"name": "",
                         				"type": "tuple"
                         			}
                         		],
                         		"stateMutability": "view",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [],
                         		"name": "getDomainsForSale",
                         		"outputs": [
                         			{
                         				"internalType": "bytes[]",
                         				"name": "",
                         				"type": "bytes[]"
                         			},
                         			{
                         				"components": [
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
                         						"name": "pointedAddress",
                         						"type": "bytes"
                         					},
                         					{
                         						"internalType": "bool",
                         						"name": "isTor",
                         						"type": "bool"
                         					}
                         				],
                         				"internalType": "struct Domain[]",
                         				"name": "",
                         				"type": "tuple[]"
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
                         				"name": "",
                         				"type": "uint256"
                         			}
                         		],
                         		"stateMutability": "pure",
                         		"type": "function"
                         	},
                         	{
                         		"inputs": [
                         			{
                         				"internalType": "address",
                         				"name": "user",
                         				"type": "address"
                         			}
                         		],
                         		"name": "getUserDomains",
                         		"outputs": [
                         			{
                         				"internalType": "bytes[]",
                         				"name": "",
                         				"type": "bytes[]"
                         			},
                         			{
                         				"components": [
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
                         						"name": "pointedAddress",
                         						"type": "bytes"
                         					},
                         					{
                         						"internalType": "bool",
                         						"name": "isTor",
                         						"type": "bool"
                         					}
                         				],
                         				"internalType": "struct Domain[]",
                         				"name": "",
                         				"type": "tuple[]"
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
                         		"name": "newDomainPrice",
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
                         		"outputs": [],
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
                         				"name": "ipfsAddress",
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
                         				"name": "price",
                         				"type": "uint32"
                         			}
                         		],
                         		"name": "setNewDomainPrice",
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
                         				"name": "torAddress",
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
    if (result.pointedAddress == null) {
        // Result not found.
        return null;
    }
    const domainId = await contract.methods.getId(domain).call({from: user});
    const owner = await contract.methods.ownerOf(domainId).call({from: user});
    return JSON.stringify({
        price: result.price,
        resoldTimes: result.resoldTimes,
        pointedAddress: result.pointedAddress,
        isTor: result.isTor,
        owner: owner,
    });
}

async function domains_getMyDomains() {
    const [contract, user] = await _initializeGethDomainsContract();
    // getUserDomains returns 2 parallel arrays
    const domainsList = await contract.methods.getUserDomains(user).call({from: user});
    const result = [];
    for (let i = 0; i < domainsList[0].length; i++) {
        const domainBytes = domainsList[0][i];
        const domain = domainsList[1][i];
        result.push({
            domain: domainBytes,
            price: domain.price,
            resoldTimes: domain.resoldTimes,
            pointedAddress: domain.pointedAddress,
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


async function domains_sellDomain_fees(domainBytes, price) {
    domainBytes = _receiveBytes(domainBytes);
    const [contract, user] = await _initializeGethDomainsContract();
    const gas = await contract.methods.sellDomain(domainBytes, price).estimateGas({from: user});
    return gas.toString();
}

async function domains_sellDomain(domainBytes, price) {
    domainBytes = _receiveBytes(domainBytes);
    const [contract, user] = await _initializeGethDomainsContract();
    console.log('Sending transaction with args:', {domainBytes, price});
    const gas = await contract.methods.sellDomain(domainBytes, price).estimateGas({from: user});
    const txHash = await wrapContractSend(contract.methods.sellDomain(domainBytes, price).send({from: user, gas: gas}));
    return txHash;
}


async function domains_retrieveDomain(domainBytes) {
    domainBytes = _receiveBytes(domainBytes);
    const [contract, user] = await _initializeGethDomainsContract();
    const gas = await contract.methods.retrieveDomain(domainBytes).estimateGas({from: user});
    const txHash = await wrapContractSend(contract.methods.retrieveDomain(domainBytes).send({from: user, gas: gas}));
    return txHash;
}


async function domains_getDomainsForSale() {
    const [contract, user] = await _initializeGethDomainsContract();
    const domainsList = await contract.methods.getDomainsForSale().call({from: user});
    const result = [];
    for (let i = 0; i < domainsList[0].length; i++) {
        const domainBytes = domainsList[0][i];
        const domain = domainsList[1][i];
        result.push({
            domain: domainBytes,
            price: domain.price,
            resoldTimes: domain.resoldTimes,
            pointedAddress: domain.pointedAddress,
            isTor: domain.isTor,
            owner: user,
        });
    }

    return JSON.stringify(result);
}


async function domains_purchaseExistingDomain(domainBytes, price) {
    domainBytes = _receiveBytes(domainBytes);
    const [contract, user] = await _initializeGethDomainsContract();
    const gas = await contract.methods.purchaseExistingDomain(domainBytes, price).estimateGas({from: user});
    const txHash = await wrapContractSend(contract.methods.purchaseExistingDomain(domainBytes, price).send({from: user, gas: gas}));
    return txHash;
}


async function domains_editDomainPointer_fees(domainBytes, pointedAddress, domainType) {
    domainBytes = _receiveBytes(domainBytes);
    pointedAddress = _receiveBytes(pointedAddress);
    const isTor = domainType === 'tor';
    const [contract, user] = await _initializeGethDomainsContract();

    const contractMethod = isTor ? contract.methods.setTor : contract.methods.setIpfs;
    const gas = await contractMethod(domainBytes, pointedAddress).estimateGas({from: user});
    return gas.toString();
}

async function domains_editDomainPointer(domainBytes, pointedAddress, domainType) {
    domainBytes = _receiveBytes(domainBytes);
    pointedAddress = _receiveBytes(pointedAddress);
    const isTor = domainType === 'tor';
    const [contract, user] = await _initializeGethDomainsContract();

    const contractMethod = isTor ? contract.methods.setTor : contract.methods.setIpfs;
    const gas = await contractMethod(domainBytes, pointedAddress).estimateGas({from: user});
    const txHash = await wrapContractSend(contractMethod(domainBytes, pointedAddress).send({from: user, gas: gas}));
    return txHash;
}


async function domains_getDomainOriginalOwner(domainBytes) {
    domainBytes = _receiveBytes(domainBytes);
    const [contract, user] = await _initializeGethDomainsContract();
    const domainId = await contract.methods.getId(domainBytes).call({from: user});
    const royaltyInfo = await contract.methods.royaltyInfo(domainId, 1).call({from: user});
    return royaltyInfo[0];
}


let domains_sent_event_emitter = null;
let domains_received_event_emitter = null;
let domains_listing_event_emitter = null;
let domains_selling_event_emitter = null;
let domains_royalties_event_emitter = null;
let domains_ipfs_overwritten_event_emitter = null;
let domains_tor_overwritten_event_emitter = null;
async function _initDomainsEvents() {
    // Remove all the previous listeners
    [
        domains_sent_event_emitter,
        domains_received_event_emitter,
        domains_listing_event_emitter,
        domains_selling_event_emitter,
        domains_royalties_event_emitter,
        domains_ipfs_overwritten_event_emitter,
        domains_tor_overwritten_event_emitter,
    ].filter((x) => x !== null).forEach((x) => {
        x.removeAllListeners('data');
        x.removeAllListeners('error');
    });

    const [contract, user] = await _initializeGethDomainsContract();
    if (user === null) {
        console.log('Not logged in, not subscribing to events for domains');
        return;
    }
    console.log('Initializing events for domains for user', user);

    // Subscribe to Transfer events from or to me
    const _onEvent = async function(event) {
        console.log(event);
         const tokenId = event.returnValues.tokenId;
         const domainInfo = await contract.methods.getDomainById(tokenId).call({from: user});
         const domainBytes = domainInfo[0];
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

    // Subscribe to DomainForSale events
    domains_listing_event_emitter = contract.events.DomainForSale().on('data', async function(event) {
        console.log(event);
        web3EventsSink('domainListingForSale', JSON.stringify({
            domainBytes: event.returnValues.domain,
            seller: event.returnValues.seller,
            price: event.returnValues.price,
        }));
    }).on('error', _onError);

    // Subscribe to DomainSold events
    domains_selling_event_emitter = contract.events.DomainSold().on('data', async function(event) {
        console.log(event);
        web3EventsSink('domainSold', JSON.stringify({
            domainBytes: event.returnValues.domain,
            buyer: event.returnValues.buyer,
            seller: event.returnValues.seller,
        }));
    }).on('error', _onError);

    // Subscribe to RoyaltiesPaid events
    domains_royalties_event_emitter = contract.events.RoyaltiesPaid({
        filter: {originalOwner: user}
    }).on('data', async function(event) {
        console.log(event);
        web3EventsSink('royaltiesPaid', JSON.stringify({
            domainBytes: event.returnValues.domain,
            royaltiesAmount: event.returnValues.royaltiesAmount,
        }));
    }).on('error', _onError);

    // Subscribe to IpfsOverwritten and TorOverwritten events
    const _onOverwrittenEvent = function(event) {
        console.log(event);
        web3EventsSink('domainPointerOverwritten', JSON.stringify({
            domainBytes: event.returnValues.domain,
            owner: event.returnValues.owner,
        }));
    };
    domains_ipfs_overwritten_event_emitter = contract.events.IpfsOverwritten().on('data', _onOverwrittenEvent).on('error', _onError);
    domains_tor_overwritten_event_emitter = contract.events.TorOverwritten().on('data', _onOverwrittenEvent).on('error', _onError);
}
_initDomainsEvents().catch(console.error);