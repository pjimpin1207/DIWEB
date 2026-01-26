const fs = require('fs');
const path = require('path');

const postsDir = path.join(__dirname, '../posts');

function getAllFiles(dirPath, arrayOfFiles) {
  const files = fs.readdirSync(dirPath);
  arrayOfFiles = arrayOfFiles || [];

  files.forEach(function(file) {
    if (fs.statSync(dirPath + "/" + file).isDirectory()) {
      arrayOfFiles = getAllFiles(dirPath + "/" + file, arrayOfFiles);
    } else {
      if (file.endsWith('.html') && file !== 'index.html' && !file.includes('Ejercicio2.html')) {
        arrayOfFiles.push(path.join(dirPath, "/", file));
      }
    }
  });

  return arrayOfFiles;
}

const allPosts = getAllFiles(postsDir);

console.log(`Found ${allPosts.length} posts to update.`);

allPosts.forEach(filePath => {
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Extract Data
  const titleMatch = content.match(/<h2>(.*?)<\/h2>/);
  const title = titleMatch ? titleMatch[1] : 'Ejercicio';

  const dateMatch = content.match(/Publicado el <em>(.*?)<\/em>/);
  const date = dateMatch ? dateMatch[1] : 'Fecha desconocida';

  const bodyMatch = content.match(/<div class="post-body">([\s\S]*?)<\/div>/);
  const bodyContent = bodyMatch ? bodyMatch[1] : '';

  // Infer Topic
  const topicMatch = filePath.match(/Tema(\d+)/);
  const topicNum = topicMatch ? topicMatch[1] : '1';
  const topicName = `Tema ${topicNum}`;
  const topicPath = `../Tema${topicNum}/index.html`;

  // Fix button class if needed in body
  let fixedBody = bodyContent.replace('class="btn"', 'class="btn-exercise"');
  fixedBody = fixedBody.replace('Ver resultado del ejercicio', '🚀 Ver resultado del ejercicio');
  
  // New HTML Template
  const newHtml = `<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${title.replace(/<[^>]*>?/gm, '')} - Blog DIWEB</title>
  <link rel="stylesheet" href="../../css/post.css" />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
</head>
<body>

  <!-- READING PROGRESS BAR -->
  <div class="progress-container">
    <div class="progress-bar" id="myBar"></div>
  </div>

  <div class="bg-gradient"></div>

  <!-- TOPIC NAVIGATION -->
  <nav class="topic-nav" style="position: sticky; top: 1rem; z-index: 100; max-width: 900px; margin: 1rem auto;">
    <a href="../../index.html" class="nav-home">
       <span>🏠</span> Blog DIWEB
    </a>
    <div class="nav-menu">
      <a href="../../index.html">Inicio</a>
      <a href="../Tema${topicNum}/index.html" class="active">Tema ${topicNum}</a>
    </div>
  </nav>

  <div class="post-wrapper">
    <article class="post-article">
      <header class="post-header">
        <h1 class="post-title">${title}</h1>
        <div class="post-meta">
          <span>📅 ${date}</span>
          <span>✍️ <strong>Pablo Jiménez</strong></span>
          <span>📚 ${topicName}</span>
        </div>
      </header>

      <div class="post-body">
        ${fixedBody}
      </div>
    </article>

    <div class="back-link">
      <a href="${topicPath}" class="btn-link" style="display: inline-block;">← Volver al Temario</a>
    </div>
  </div> 

  <!-- MULTI-COLUMN FOOTER COPIED -->
  <footer class="main-footer" style="margin-top: 0;">
    <div class="footer-content">
      <div class="footer-col">
        <h3>Pablo Jiménez</h3>
        <p>Desarrollador web en formación.</p>
        <div class="profile-links">
           <a href="https://github.com/pjimpin1207" target="_blank" class="btn-link github">GitHub ↗</a>
        </div>
      </div>
      <div class="footer-col">
        <h3>Explora</h3>
        <ul class="footer-links">
          <li><a href="../../index.html">Inicio</a></li>
          <li><a href="${topicPath}">Tema ${topicNum}</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© 2025 Pablo Jiménez — Blog DIWEB</p>
    </div>
  </footer>

  <script>
    // Progress Bar Script
    window.onscroll = function() {myFunction()};
    function myFunction() {
      var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
      var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
      var scrolled = (winScroll / height) * 100;
      document.getElementById("myBar").style.width = scrolled + "%";
    }
  </script>
</body>
</html>`;

  fs.writeFileSync(filePath, newHtml);
  console.log(`Updated: ${path.basename(filePath)}`);
});
