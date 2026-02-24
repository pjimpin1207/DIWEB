import os

replacements = {
    "ðŸ  ": "🏠",
    "ðŸ WhatsApp": "📅",  # Sometimes it gets mangled to this?
    "ðŸ“…": "📅",
    "âœ ï¸ ": "✍️",
    "ðŸ“š": "📚",
    "ðŸ“„": "📄",
    "ðŸŽ¯": "🎯",
    "1ï¸ âƒ£": "1️⃣",
    "2ï¸ âƒ£": "2️⃣",
    "3ï¸ âƒ£": "3️⃣",
    "4ï¸ âƒ£": "4️⃣",
    "ðŸ“ ": "📌",
    "ðŸ’»": "💻",
    "âœ…": "✅",
    "â “": "❓",
    "ðŸ” ": "🔍",
    "ðŸ“¦": "📦",
    "â† ": "←",
    "Â©": "©",
    "â†—": "↗",
    "Ã±": "ñ",
    "Ã­": "í",
    "Ã©": "é",
    "Ã¡": "á",
    "Ã³": "ó",
    "Ãº": "ú",
    "Â¿": "¿",
    "Â¡": "¡",
    "â€“": "–",
    "â€œ": "“",
    "â€ ": "”",
    "Ãš": "Ú",
    "Ã ": "à",
    "Ã¨": "è",
    "Ã¬": "ì",
    "Ã²": "ò",
    "Ã¹": "ù",
    "Ã€": "À",
    "Ãˆ": "È",
    "ÃŒ": "Ì",
    "Ã’": "Ò",
    "Ã™": "Ù",
    "âš™ï¸ ": "⚙️",
    "ðŸŽ¨": "🎨",
}

directory = r"c:\Users\pablo\Documents\DAW\DIWEB\posts\Tema3"
files_to_fix = ["Ejercicio1.html", "Ejercicio2.html", "Ejercicio3.html"]

for filename in files_to_fix:
    filepath = os.path.join(directory, filename)
    if not os.path.exists(filepath):
        print(f"Skipping {filename}: Not found")
        continue
    
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    original_content = content
    for mangled, correct in replacements.items():
        content = content.replace(mangled, correct)
    
    # Also handle some special cases that might have different variations
    # like "Pablo JimÃ©nez" which might be "Pablo Jiménez" in some lines but not others
    content = content.replace("JimÃ©nez", "Jiménez")
    content = content.replace("Â¿QuÃ©", "¿Qué")
    content = content.replace("aplicarÃ­a", "aplicaría")
    content = content.replace("automÃ¡ticamente", "automáticamente")
    content = content.replace("cÃ³digo", "código")
    content = content.replace("teÃ³rica", "teórica")
    content = content.replace("finalizaciÃ³n", "finalización")
    content = content.replace("CompilaciÃ³n", "Compilación")
    content = content.replace("reflexiÃ³n", "reflexión")
    content = content.replace("pÃ¡gina", "página")
    content = content.replace("lÃ­nea", "línea")
    content = content.replace("ratÃ³n", "ratón")
    content = content.replace("SoluciÃ³n", "Solución")
    content = content.replace("Ãšnicamente", "Únicamente")
    content = content.replace("serÃ­a", "sería")

    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed {filename}")
    else:
        print(f"No changes needed for {filename}")
