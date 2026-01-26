$postsDir = Resolve-Path "posts"
$files = Get-ChildItem -Path $postsDir -Recurse -Filter "*.html"

Write-Host "Found $($files.Count) files."

foreach ($file in $files) {
    if ($file.Name -eq "index.html" -or $file.Name -eq "Ejercicio2.html") {
        continue
    }

    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Extract Title
    $titleMatch = $content | Select-String -Pattern "<h2>(.*?)<\/h2>"
    $title = "Ejercicio"
    if ($titleMatch) {
        $title = $titleMatch.Matches.Groups[1].Value
    }

    # Extract Date
    $dateMatch = $content | Select-String -Pattern "Publicado el <em>(.*?)<\/em>"
    $date = "Fecha desconocida"
    if ($dateMatch) {
         $date = $dateMatch.Matches.Groups[1].Value
    }

    # Extract Body
    $bodyMatch = $content | Select-String -Pattern '<div class="post-body">([\s\S]*?)<\/div>'
    $bodyContent = ""
    if ($bodyMatch) {
        $bodyContent = $bodyMatch.Matches.Groups[1].Value
    }

    # Topic Logic
    $topicNum = "1"
    if ($file.FullName -match "Tema(\d+)") {
        $topicNum = $Matches[1]
    }
    $topicName = "Tema $topicNum"
    $topicPath = "../Tema$topicNum/index.html"

    # Fix Button
    $fixedBody = $bodyContent -replace 'class="btn"', 'class="btn-exercise"'
    $fixedBody = $fixedBody -replace 'Ver resultado del ejercicio', '🚀 Ver resultado del ejercicio'

    # New HTML
    $newHtml = @"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>$($title -replace '<[^>]+>','') - Blog DIWEB</title>
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
      <a href="../Tema$topicNum/index.html" class="active">Tema $topicNum</a>
    </div>
  </nav>

  <div class="post-wrapper">
    <article class="post-article">
      <header class="post-header">
        <h1 class="post-title">$title</h1>
        <div class="post-meta">
          <span>📅 $date</span>
          <span>✍️ <strong>Pablo Jiménez</strong></span>
          <span>📚 $topicName</span>
        </div>
      </header>

      <div class="post-body">
        $fixedBody
      </div>
    </article>

    <div class="back-link">
      <a href="$topicPath" class="btn-link" style="display: inline-block;">← Volver al Temario</a>
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
          <li><a href="$topicPath">Tema $topicNum</a></li>
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
</html>
"@

    $newHtml | Set-Content -Path $file.FullName -Encoding UTF8
    Write-Host "Updated $($file.Name)"
}
