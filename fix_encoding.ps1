$filePath = "posts\Tema3\Proyecto.html"
# Read as UTF8 to see the mojibake characters correctly
$content = Get-Content -Path $filePath -Raw -Encoding utf8

$replacements = @{
    "Ã³" = "ó"
    "Ã©" = "é"
    "Ã¡" = "á"
    "Ã­" = "í"
    "Ã±" = "ñ"
    "Ãº" = "ú"
    "Ã " = "à"
    "â€“" = "–"
    "ðŸ  " = "🏠"
    "ðŸ“…" = "📅"
    "âœ ï¸ " = "✍️"
    "ðŸ“š" = "📚"
    "â”œâ”€" = "├──"
    "â”‚" = "│"
    "â””â”€" = "└──"
    "ðŸ” " = "🔍"
    "ðŸ’»" = "💻"
    "â† " = "←"
    "Â©" = "©"
    "â†—" = "↗"
}

foreach ($old in $replacements.Keys) {
    $content = $content.Replace($old, $replacements[$old])
}

# Save as UTF8
[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)

Write-Host "Replacement complete."
