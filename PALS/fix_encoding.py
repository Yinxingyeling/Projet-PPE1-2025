# fix_encoding.py
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, encoding="utf-8") as f:
    text = f.read()

# Corrections ciblées de mojibake fréquents
replacements = {
    # Apostrophes et ponctuation
    "€™": "",
    "Â«": "",
    "Â»": "",

    # Encodage simple cassé
    "Ã©": "é",
    "Ã¨": "è",
    "Ãª": "ê",
    "Ã ": "à",
    "Ã§": "ç",
    "Ã´": "ô",
    "Ã®": "î",
    "Ã¯": "ï",
    "Ã¹": "ù",
    "Ã»": "û",

    # Double encodage
    "ÃƒÂ©": "é",
    "ÃƒÂ¨": "è",
    "ÃƒÂª": "ê",
    "ÃƒÂ ": "à",
    "ÃƒÂ§": "ç",
    "ÃƒÂ´": "ô",
    "ÃƒÂ®": "î",
    "ÃƒÂ¯": "ï",
    "ÃƒÂ¹": "ù",
    "ÃƒÂ»": "û",
}

for bad, good in replacements.items():
    text = text.replace(bad, good)

with open(output_file, "w", encoding="utf-8") as f:
    f.write(text)
