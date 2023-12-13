from konlpy.tag import Kkma
import errno
import fileinput

tokenizer = Kkma()

try:
    for line in fileinput.input():
        if len(line.strip()) > 0:
            tokens = [tok for tok, _ in tokenizer.pos(line)]
            print(" ".join(tokens))
except IOError as e:
    if e.errno != errno.EPIPE:
        raise
