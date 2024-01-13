// Importa il contratto da testare
const Geth = artifacts.require('Geth');

// Dichiarazione del contratto e dell'account
contract('Geth', (accounts) => {
  let gethInstance;
  const deployerAccount = accounts[0];
  const buyerAccount = accounts[1];

  // Esegui prima di ogni test
  // sta creando una nuova istanza del contratto Geth prima di ogni test. 
  // Questo è utile perché ti fornisce un ambiente pulito e isolato per eseguire ciascun test.
  // Ogni test viene eseguito con una nuova istanza del contratto, evitando così possibili interferenze tra uno e l'altro.
  beforeEach(async () => {
    gethInstance = await Geth.new({ from: deployerAccount });
  });

  // Testa la funzione purchaseTokens
  it('should allow buying tokens with Ether', async () => {
    const ethAmount = web3.utils.toWei('1', 'ether');
    await gethInstance.purchaseTokens({ from: buyerAccount, value: ethAmount });
    const balance = await gethInstance.balanceOf(buyerAccount);
    assert.equal(balance.toNumber(), 1000, 'Tokens not received');
  });

  // Testa la funzione purchaseWei
  it('should allow selling tokens for Ether', async () => {
    const ethAmount = web3.utils.toWei('1', 'ether');
    const tokenAmount = 1000; // Adjust based on your conversion rate
    await gethInstance.purchaseTokens({ from: buyerAccount, value: ethAmount });
    await gethInstance.purchaseWei(tokenAmount, { from: buyerAccount });
    const balance = await web3.eth.getBalance(buyerAccount);
    assert.equal(balance.toString(), ethAmount, 'Ether not received');
  });

  // Aggiungi altri test a seconda delle funzionalità del tuo contratto
});
