import os

file_path = r'c:\Users\pablo\Documents\DAW\DIWEB\posts\Tema3\Proyecto.html'

# Common mojibake patterns (UTF-8 bytes seen as windows-1252)
replacements = {
    'Ã³': 'ó',
    'Ã©': 'é',
    'Ã¡': 'á',
    'Ã­': 'í',
    'Ã±': 'ñ',
    'Ãº': 'ú',
    'Ã ': 'à',
    'â€“': '–',
    'ðŸ  ': '🏠',
    'ðŸ“…': '📅',
    'âœ ï¸ ': '✍️',
    'ðŸ“š': '📚',
    'â”œâ”€': '├──',
    'â”‚': '│',
    'â””â”€': '└──',
    'ðŸ” ': '🔍',
    'ðŸ’»': '💻',
    'â† ': '←',
    'Â©': '©',
    'â†—': '↗',
}

# Add some variations just in case
replacements['Pablo JimÃ©nez'] = 'Pablo Jiménez'
replacements['DescripciÃ³n'] = 'Descripción'
replacements['refactorizaciÃ³n'] = 'refactorización'
replacements['cÃ³digo'] = 'código'
replacements['haciÃ©ndolo'] = 'haciéndolo'
replacements['mÃ¡s'] = 'más'
replacements['prÃ¡cticas'] = 'prácticas'
replacements['pÃ¡gina'] = 'página'
replacements['AplicaciÃ³n'] = 'Aplicación'
replacements['OrganizaciÃ³n'] = 'Organización'
replacements['CompilaciÃ³n'] = 'Compilación'
replacements['tÃ©cnicos'] = 'técnicos'
replacements['tipografÃ­as'] = 'tipografías'
replacements['navegaciÃ³n'] = 'navegación'
replacements['aritmÃ©ticos'] = 'aritméticos'
replacements['aÃ±adido'] = 'añadido'

with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

# Also try reading as latin-1 if utf-8 ignore misses things
# Actually, if the file has those sequences, it means it's ALREADY corrupted text in a UTF-8 file.
# i.e., the characters "Ã³" are literally in the file.

for old, new in replacements.items():
    content = content.replace(old, new)

# One more pass for any individual Ã characters missed
# content = content.replace('Ã³', 'ó') # already done

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Replacement complete.")
