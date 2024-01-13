// const { BigNumber } = require('web3-utils');
const DomainMarketplace = artifacts.require('DomainMarketplace');
const GethToken = artifacts.require('Geth'); // Assicurati di sostituire con il nome del tuo contratto ERC20

contract('DomainMarketplace', (accounts) => {
  let domainMarketplace;
  let gethToken;

  const owner = accounts[0];
  const seller = accounts[1];
  const buyer = accounts[2];
  const ethAmount = web3.utils.toWei('0.01', 'ether');


  beforeEach(async () => {
    gethToken = await GethToken.new({ from: owner });
    domainMarketplace = await DomainMarketplace.new(gethToken.address, { from: owner });
    await gethToken.setOperator(domainMarketplace.address, { from: owner });
    // seller acquista token
    await gethToken.purchaseTokens({ from: seller, value: ethAmount });

    // buyer acquista token
    await gethToken.purchaseTokens({ from: buyer, value: ethAmount });
  });

  it('should allow purchase of a new domain', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    // await gethToken.approve(domainMarketplace.address, 10, { from: seller });
    
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });

    // const domainOwner = await domainMarketplace.ownerOf(0);
    const domainInfo = await domainMarketplace.domains(domain);
    // const expectedTorOrIpfs = new BigNumber(torOrIpfs);
    // const actualTorOrIpfs = new BigNumber(domainInfo.dominioTorOrIpfs);

    // // Usa l'asserzione di chai per confrontare i numeri invece delle stringhe esadecimali
    // assert.isTrue(actualTorOrIpfs.eq(expectedTorOrIpfs), 'Expected TorOrIpfs to be equal');
    // assert.strictEqual(domainOwner, seller);
    assert.strictEqual(domainInfo.price.toNumber(), 0);
    assert.strictEqual(domainInfo.resoldTimes.toNumber(), 1);
    assert.strictEqual(domainInfo.isTor, isTor);
  });

  it('should allow selling an existing domain', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    const salePrice = 10;

    // await gethToken.approve(domainMarketplace.address, salePrice, { from: seller });
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });

    await domainMarketplace.sellDomain(domain, salePrice, { from: seller });

    const domainInfo = await domainMarketplace.domains(domain);
    assert.strictEqual(domainInfo.price.toNumber(), salePrice);
  });

  it('should allow buying an existing domain', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    const salePrice = 10;

    // await gethToken.approve(domainMarketplace.address, salePrice, { from: seller });
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });
    await domainMarketplace.sellDomain(domain, salePrice, { from: seller });

    // await gethToken.approve(domainMarketplace.address, salePrice, { from: buyer });
    await domainMarketplace.purchaseExistingDomain(domain, { from: buyer });

    // const domainOwner = await domainMarketplace.ownerOf(0);
    const domainInfo = await domainMarketplace.domains(domain);

    // assert.strictEqual(domainOwner, buyer);
    assert.strictEqual(domainInfo.price.toNumber(), 0);
    assert.strictEqual(domainInfo.resoldTimes.toNumber(), 2);
  });

  it('should allow retrieving a domain from sale', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    const salePrice = 10;

    await gethToken.approve(domainMarketplace.address, salePrice, { from: seller });
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });
    await domainMarketplace.sellDomain(domain, salePrice, { from: seller });

    await domainMarketplace.retrieveDomain(domain, { from: seller });

    const domainInfo = await domainMarketplace.domains(domain);
    assert.strictEqual(domainInfo.price.toNumber(), 0);
  });

  // Aggiungi altri test a seconda delle funzionalità del tuo contratto
});
