import re
import sys

def clean_tokens(input_file, output_file, stopwords_file="stopwords_zh_cooc.txt"):

    # stopwords
    with open(stopwords_file, encoding="utf-8") as f:
        STOPWORDS = set(w.strip() for w in f if w.strip())

    # ponctuations : filtrage supplementaire de ponctuations
    punct_re = re.compile(r"^[，。！？、；：…!?\"'（）]+$")

    # chiffres et lettres
    num_let_re = re.compile(r"^[A-Za-z0-9]+$")

    # nettoyer
    with open(input_file, encoding="utf-8") as fi, open(output_file, "w", encoding="utf-8") as fo:

        for line in fi:
            token = line.strip()

            if not token:
                continue
            if token in STOPWORDS:
                continue
            if punct_re.match(token):
                continue
            if num_let_re.match(token):
                continue

            fo.write(token + "\n")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("clean_cooccurrence_chinois.py a besoin de 3 arguments: INPUT OUTPUT [STOPWORDS]")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    stopwords_file = sys.argv[3] if len(sys.argv) > 3 else "stopwords_zh_cooc.txt"

    clean_tokens(input_file, output_file, stopwords_file)

    print("Clean corpus for cooccurrence: done.")
