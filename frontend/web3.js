import Web3 from "web3";

const getWeb3 = async () => {
  if (window.ethereum) {
    try {
      // Request account access
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const web3 = new Web3(window.ethereum);
      console.log("MetaMask connected!");
      return web3;
    } catch (error) {
      console.error("User denied account access");
    }
  } else if (window.web3) {
    // Legacy dapp browsers
    const web3 = new Web3(window.web3.currentProvider);
    console.log("MetaMask connected!");
    return web3;
  } else {
    console.log("Non-Ethereum browser detected. Install MetaMask!");
  }
};

export default getWeb3;
