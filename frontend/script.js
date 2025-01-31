// Connect Wallet Button
document.getElementById('connectWallet').addEventListener('click', async () => {
    if (window.ethereum) {
      try {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        alert(`Connected: ${accounts[0]}`);
      } catch (error) {
        console.error(error);
        alert('Connection failed.');
      }
    } else {
      alert('Please install MetaMask.');
    }
  });
  
  // Submit News Form
  document.getElementById('submitNewsForm').addEventListener('submit', (e) => {
    e.preventDefault();
    const title = document.getElementById('newsTitle').value;
    const content = document.getElementById('newsContent').value;
  
    alert(`News Submitted!\nTitle: ${title}\nContent: ${content}`);
  
    // Clear form fields after submission
    document.getElementById('submitNewsForm').reset();
  });
  