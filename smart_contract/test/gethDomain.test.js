const DomainMarketplace = artifacts.require('DomainMarketplace');
const GethToken = artifacts.require('Geth'); 

contract('DomainMarketplace', (accounts) => {
  let domainMarketplace;
  let gethToken;

  const owner = accounts[0];
  const seller = accounts[1];
  const buyer = accounts[2];
  const ethAmount = web3.utils.toWei('0.01', 'ether');

  // operations done before each test
  beforeEach(async () => {
    gethToken = await GethToken.new({ from: owner });
    domainMarketplace = await DomainMarketplace.new(gethToken.address, { from: owner });
    await gethToken.setOperator(domainMarketplace.address, { from: owner });
    // seller purchase token
    await gethToken.purchaseTokens({ from: seller, value: ethAmount });

    // buyer purchase token
    await gethToken.purchaseTokens({ from: buyer, value: ethAmount });
  });

  it('should allow purchase of a new domain', async () => {
    // domain information
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    
    // domain purchase
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });

    // get actual domain info
    const domainInfo = await domainMarketplace.domains(domain);
    const idActualDomain = await domainMarketplace.getId(domain);
    const actualDomainOwner = await domainMarketplace.ownerOf(idActualDomain);
    const actualTorOrIpfs = domainInfo.pointedAddress;
    const actualIsTor = domainInfo.isTor;
    const actualPrice = domainInfo.price.toNumber();
    const actualResoldTimes = domainInfo.resoldTimes.toNumber();

    // check domain info
    assert.equal(actualPrice, 0, "Price does not match");
    assert.equal(actualResoldTimes, 1, "Resold times does not match");
    assert.equal(actualIsTor, isTor, "IsTor does not match");
    assert.equal(actualTorOrIpfs, torOrIpfs, "Tor or Ipfs address does not match");
    assert.equal(actualDomainOwner, seller, 'Owner address does not match');
  });

  it('should allow selling an existing domain', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    const salePrice = 10;

    // domain purchase
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });
    // domain sale
    await domainMarketplace.sellDomain(domain, salePrice, { from: seller });

    // get actual domain info
    const domainInfo = await domainMarketplace.domains(domain);
    const idActualDomain = await domainMarketplace.getId(domain);
    const actualDomainOwner = await domainMarketplace.ownerOf(idActualDomain);
    const actualPrice = domainInfo.price.toNumber();

    // check domain state
    assert.equal(actualPrice, salePrice);
    assert.equal(actualDomainOwner, seller, 'Owner address does not match');

  });



  it('should allow buying an existing domain', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    const salePrice = 10;

    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });
    await domainMarketplace.sellDomain(domain, salePrice, { from: seller });

    // buy existing domain
    await domainMarketplace.purchaseExistingDomain(domain, salePrice, { from: buyer });

    // get actual domain info
    const domainInfo = await domainMarketplace.domains(domain);
    const idActualDomain = await domainMarketplace.getId(domain);
    const actualDomainOwner = await domainMarketplace.ownerOf(idActualDomain);
    const actualPrice = domainInfo.price.toNumber();
    const actualResoldTimes = domainInfo.resoldTimes.toNumber();

    // check domain state
    assert.strictEqual(actualPrice, 0);
    assert.strictEqual(actualResoldTimes, 2, "Resold times does not match");
    assert.equal(actualDomainOwner, buyer, 'Owner address does not match');
  });

  it('should allow retrieving a domain from sale', async () => {
    const domain = 0xeeeeeeeeeeee;
    const torOrIpfs = 0xeeeeeeeeeeee;
    const isTor = true;
    const salePrice = 10;
    await domainMarketplace.purchaseNewDomain(domain, torOrIpfs, isTor, { from: seller });
    await domainMarketplace.sellDomain(domain, salePrice, { from: seller });

    // check if someone else tries to retrieve the domain
    try {
      await domainMarketplace.retrieveDomain(domain, { from: buyer });
      assert.fail('Expected an exception but got success');
    } catch (error) {
        assert.include(
            error.message,
            'revert', 
            'Expected a revert exception, but got ' + error
        );
    }

    // retreive domain
    await domainMarketplace.retrieveDomain(domain, { from: seller });

    // get actual domain info
    const domainInfo = await domainMarketplace.domains(domain);
    const actualPrice = domainInfo.price.toNumber();
    const idActualDomain = await domainMarketplace.getId(domain);
    const actualDomainOwner = await domainMarketplace.ownerOf(idActualDomain);

    // check domain and owner
    assert.equal(actualPrice, 0);
    assert.equal(actualDomainOwner, seller, 'Owner address does not match');
  });

});