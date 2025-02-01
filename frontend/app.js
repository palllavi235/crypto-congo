import React, { useEffect, useState } from "react";
import getContract from "./contract";
import getWeb3 from "./web3";

function App() {
  const [account, setAccount] = useState("");
  const [contract, setContract] = useState(null);

  useEffect(() => {
    const init = async () => {
      const web3 = await getWeb3();
      const contract = await getContract();
      const accounts = await web3.eth.getAccounts();
      setContract(contract);
      setAccount(accounts[0]);
    };
    init();
  }, []);

  const handleConnect = async () => {
    const web3 = await getWeb3();
    if (web3) {
      const accounts = await web3.eth.getAccounts();
      setAccount(accounts[0]);
    }
  };

  return (
    <div>
      <h1>Decentralized News Platform</h1>
      {account ? (
        <p>Connected Account: {account}</p>
      ) : (
        <button onClick={handleConnect}>Connect MetaMask</button>
      )}
    </div>
  );
}

export default App;
