

// Submit News Form
document.getElementById('submitNewsForm').addEventListener('submit', (e) => {
  e.preventDefault();
  
  const title = document.getElementById('newsTitle').value;
  const content = document.getElementById('newsContent').value;
  const media = document.getElementById('newsMedia').files[0];

  alert(`News Submitted!\nTitle: ${title}\nContent: ${content}\nMedia: ${media ? media.name : 'No media uploaded'}`);

  document.getElementById('submitNewsForm').reset();
});
