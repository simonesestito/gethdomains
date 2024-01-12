// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DomainMarketplace is ERC721Royalty, Ownable {

    // Struct per rappresentare un dominio
    struct Domain {
        // bytes domainName;
        // address originalOwner;
        // address currentOwner;
        // uint256 id;
        // bool inSale;
        uint32 price;
        uint32 resoldTimes ; //contatore per sapere quante volte il dominio è stato venduto
        bytes dominioTorOrIpfs;
        bool isTor; // 1 byte
        // bytes dominioIpfs; // header > 1 byte ?
    }

    IERC20 payGeth;

    // ID corrente dei domini
    // uint256 public nextId;

    // prezzo base
    uint32 public prezzoBase = 10;

    // Mappa per associare l'ID del dominio alla struttura Domain
    mapping(bytes => Domain) public domains;

    bytes[] public keys;

    // Evento emesso quando un dominio viene messo in vendita
    // indexed è utilizzato per permettere i destinatari di filtrare gli eventi in base al valore del par
    event DomainForSale(bytes domain, address indexed seller, uint256 price);

    // Evento emesso quando un dominio è stato venduto per aggiornare la vista dei domini in vendita
    // Non ho messo il prezzo perchè non interessa più non essendo appunto in vendita ** TEORICAMENTE POTREBBE ESSERE INTERESSANTE SAPERE A QUANTO E' STATO VENDUTO UN DOMINIO
    event DomainSold(address seller, address indexed buyer, bytes domain);

    // Evento emesso quando un dominio viene acquistato e le royalties vengono inviate all'acquirente originale
    event RoyaltiesPaid(address indexed originalOwner, address indexed buyer, bytes domain, uint256 royaltiesAmount);

    // Evento emesso quando sovrascrivi un dominioTor con uno ipfs
    event TorOverwritten(bytes domain, address indexed owner);

    // Evento emesso quando sovrascrivi un dominioIpfs con uno tor
    event IpfsOverwritten(bytes domain, address indexed owner);

    // Costruttore del contratto
    constructor() ERC721("GethDomain", "GETHD") Ownable(msg.sender) {
        payGeth = IERC20(0xa514C64fd0e5Fe44B2C4448AfB8C6f3268232169);
    }

    function _feeDenominator() internal pure override returns (uint96) {
        return 20;
    }

    // function approveGeth(uint256 amount) external {
    //     require(payGeth.approve(address(this), amount), "Approval failed");
    // }

    // Funzione per acquistare un dominio ex novo
    function purchaseNewDomain(bytes calldata domain, bytes calldata torOrIpfs, bool isTor) external {
        // Verifica che il dominio non sia già stato creato
        // require(ownerOf(domains[domain].id) == address(0), "Domain already created");
        require(domains[domain].resoldTimes == 0, "Domain already created");
        // Verifica che il creator abbia abbastanza token
        require(payGeth.balanceOf(msg.sender) >= prezzoBase, "Insufficient Geth, buy them with getGeth func");
        // levare il costo dal balance
        payGeth.transferFrom(msg.sender, address(this), prezzoBase);
        // payGeth.burn(prezzoBase);
        uint256 nextId = uint256(keccak256(abi.encodePacked(domain)));
        _mint(msg.sender, nextId);  // TODO ci servono dei data oltre alla struttura salavata?
        uint96 feeNumerator = 1;  // default is 5% royalty (1/20)
        _setTokenRoyalty(nextId, msg.sender, feeNumerator);
        domains[domain] = Domain(0, 0, torOrIpfs, isTor);
        keys.push(domain);
        domains[domain].resoldTimes++;
    }

    function purchaseExistingDomain(bytes calldata domain) external {
        uint256 id = uint256(keccak256(abi.encodePacked(domain)));
        address owner = ownerOf(id);

        // Verifica che l'acquirente e il possessore non coincidano
        require(msg.sender != owner, "You cannot buy your own domain");

        // Verifica che l'acquirente abbia abbastanza token
        require(payGeth.balanceOf(msg.sender) >= domains[domain].price, "Insufficient payment");

        // Verifica che il domain sia in vendita Serve????
        require(domains[domain].price > 0, "Domain not for sale");

        domains[domain].resoldTimes++;

        //GESTIONE ROYALTIES

        address receiver;
        uint256 royaltyAmount;// Trasferisce il compenso all'acquirente originale (generatore)
        if (domains[domain].resoldTimes > 2) {

            // Calcola il compenso per l'acquirente originale (generatore)
            (receiver, royaltyAmount) = royaltyInfo(id, domains[domain].price);

            // trasferimento royalties
            payGeth.transferFrom(msg.sender, receiver, royaltyAmount);

            // Emetti l'evento per notificare l'acquirente originale (generatore) delle royalties ricevute
            emit RoyaltiesPaid(receiver, msg.sender, domain, royaltyAmount);
        }

        // Guadagno reale dalla vendita del dominio, escluse le royalties
        uint256 realAmount = domains[domain].price - royaltyAmount;

        // trasferimento amount al venditore
        payGeth.transferFrom(msg.sender, owner, realAmount);

        // trasferimento dominio
        _transfer(owner, msg.sender,id);

        // setta il prezzo a 0 quindi non in vendita
        domains[domain].price = 0;

        // Emetti l'evento per ricordare di aggiornare la lista dei domini in vendita SERVE???
        emit DomainSold(owner, msg.sender, domain);

    }

    // Modificatore che richiede che l'utente sia il proprietario del dominio
    modifier onlyDomainOwner(bytes calldata domain) {
        uint256 id = uint256(keccak256(abi.encodePacked(domain)));
        require(msg.sender == ownerOf(id), "Not the domain owner");
        _;
    }

    // Funzione per mettere un dominio in vendita
    function sellDomain(bytes calldata domain, uint32 price) external onlyDomainOwner(domain) returns (uint256 prezzo){
        require(domains[domain].price == 0, "Domain already in sale");
        // uint256 id = uint256(keccak256(abi.encodePacked(domain)));
        // prezzo maggiore di zero
        require(price > 0, "Domain are not free :(");
        // setta il dominio in vendita

        domains[domain].price = price;

        // evento per notificare gli altri utenti che un certo dominio è in vendita
        emit DomainForSale(domain, msg.sender, price);
        return price;
    }

    function retrieveDomain(bytes calldata domain) external onlyDomainOwner(domain){
        // uint256 id = uint256(keccak256(abi.encodePacked(domain)));
        require(domains[domain].price > 0, "Domain not in sale");

        domains[domain].price = 0;

        // _transfer(address(this), msg.sender, id);
        // Emetti l'evento per ricordare di aggiornare la lista dei domini in vendita SERVE???
        emit DomainForSale(domain, msg.sender, 0);
    }

    function setTor(bytes calldata domain, bytes calldata dominioTor) external onlyDomainOwner(domain) {
        // require(domains[domain].dominioIpfs.length==0,"Your domain cannot point both ipfs and tor");
        domains[domain].dominioTorOrIpfs = dominioTor;
        if (domains[domain].dominioTorOrIpfs.length > 0 && domains[domain].isTor == false) { //la prima volta è false ma perchè non è stato settato nulla magari
            emit IpfsOverwritten(domain, msg.sender);                    // se forziamo a mettere tor o ipfs da subito si può levare il check
            domains[domain].isTor = true;
        }
    }

    function setIpfs(bytes calldata domain, bytes calldata dominioIpfs) external  onlyDomainOwner(domain) {
        // require(domains[domain].dominioTor.length==0,"Your domain cannot point both ipfs and tor");
        domains[domain].dominioTorOrIpfs = dominioIpfs;
        if (domains[domain].isTor) {
            emit TorOverwritten(domain, msg.sender);
            domains[domain].isTor = false;
        }
    }

    function setPrezzoBase(uint32 prezzo) external onlyOwner {
        prezzoBase = prezzo;
    }

    function getId(bytes calldata domain) external pure returns (uint256 id) {
        return uint256(keccak256(abi.encodePacked(domain)));
    }

    function getMyDomainIndexes() external view returns (uint256[] memory) {
        uint256[] memory myDomains = new uint256[](balanceOf(msg.sender));
        uint256 j = 0;
        for (uint256 i = 0; i < keys.length; i++) {
            // Collect the indexes of all the domains owned by current user
            bytes memory domain = keys[i];
            if (ownerOf(uint256(keccak256(abi.encodePacked(domain)))) == msg.sender) {
                myDomains[j] = i;
                j += 1;
            }
        }
        return myDomains;
    }

    function findDomainById(uint256 id) external view returns (uint256) {
        for (uint256 i = 0; i < keys.length; i++) {
            bytes memory domain = keys[i];
            if (uint256(keccak256(abi.encodePacked(domain))) == id) {
                return i;
            }
        }
        return 0;
    }
}