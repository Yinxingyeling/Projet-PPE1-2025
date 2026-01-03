# fix_encoding.py
import sys
import re

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file, encoding="utf-8") as f:
    text = f.read()

# Corrections ciblées de mojibake fréquents
replacements = {
    "€™": "",        # apostrophe mojibake
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
}

for bad, good in replacements.items():
    text = text.replace(bad, good)

with open(output_file, "w", encoding="utf-8") as f:
    f.write(text)