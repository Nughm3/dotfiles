from random import randint
from colorama import init

init()
from colorama import Fore as f

arr = []
styles = [
    f.RED,
    f.GREEN,
    f.YELLOW,
    f.BLUE,
    f.LIGHTYELLOW_EX,
    f.CYAN,
    f.LIGHTRED_EX,
    f.MAGENTA,
    f.LIGHTGREEN_EX,
    f.LIGHTBLUE_EX,
]  # in random orders as I can't read my .Xresources
for _ in range(10):
    arr.append([randint(0, 9) for _ in range(10)])

for a in arr:
    for n in a:
        print(styles[n] + str(n), end=" ")
    print("")

# The BackColor property perhaps indicates a GUI? This implementation just prints to standard output with colors in the terminal instead
# Task prompt was a bit ambiguous
