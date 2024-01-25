const Geth = artifacts.require('Geth');

contract('Geth', (accounts) => {
  let gethToken;
  const deployerAccount = accounts[0];
  const buyerAccount = accounts[1];
  const ethAmount = web3.utils.toWei('0.01', 'ether');

  beforeEach(async () => {
    gethToken = await Geth.new({ from: deployerAccount });
  });

  it('should allow buying tokens with Ether', async () => {

    // purchase tokens
    await gethToken.purchaseTokens({ from: buyerAccount, value: ethAmount });

    // balance in Geth after purchase
    const balance = await gethToken.balanceOf(buyerAccount);

    // check balance
    assert.equal(balance.toNumber(), 10, 'Tokens not received');
  });

  // Testa la funzione purchaseWei
  it('should allow selling tokens for Ether', async () => {
    const tokenAmount = 10; 

    // purchase tokens
    await gethToken.purchaseTokens({ from: buyerAccount, value: ethAmount });

    // balance in ether before purchase wei
    const balance1 = await web3.eth.getBalance(buyerAccount);q

    // sell tokens
    await gethToken.purchaseWei(tokenAmount, { from: buyerAccount });

    // balance in Geth and ether after sell
    const balanceGeth = await gethToken.balanceOf(buyerAccount);
    const balance2 = await web3.eth.getBalance(buyerAccount);

    // check balances
    assert.equal(balanceGeth.toNumber(), 0, 'Tokens not sold correctly');
    assert.ok(balance2 > balance1, 'balance2 should be greater than balance1');
  });


  it('should allow the owner to withdraw Ether', async () => {
    // purchase tokens
    await gethToken.purchaseTokens({ from: buyerAccount, value: ethAmount });

    // balance in ether before withdraw
    const balance1 = await web3.eth.getBalance(deployerAccount);

    // withdraw ether
    await gethToken.destroy({ from: deployerAccount });

    // balance in ether after withdraw
    const balance2 = await web3.eth.getBalance(deployerAccount);

    // check balance
    assert.ok(balance2 > balance1, 'balance2 should be greater than balance1');
  });

});