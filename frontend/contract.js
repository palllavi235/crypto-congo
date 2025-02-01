import Web3 from "web3";

const getContract = async () => {
  const web3 = new Web3(window.ethereum);
  const contractAddress = "YOUR_CONTRACT_ADDRESS"; // Replace with your contract address
  const contractABI = [ /* Paste the ABI here */ ];
  const contract = new web3.eth.Contract(contractABI, contractAddress);
  return contract;
};

export default getContract;
