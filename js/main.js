// Búsqueda de posts por título o tags
function searchPosts() {
  const input = document.getElementById('searchInput').value.toLowerCase();
  const posts = document.querySelectorAll('#postsContainer .post');

  posts.forEach(post => {
    const title = post.querySelector('h2').textContent.toLowerCase();
    const tags = post.dataset.tags.toLowerCase();
    if (title.includes(input) || tags.includes(input)) {
      post.style.display = '';
    } else {
      post.style.display = 'none';
    }
  });
}

console.log("DIWEB cargado correctamente");