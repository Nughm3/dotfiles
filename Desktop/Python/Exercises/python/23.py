from random import randint
from colorama import init, Fore

init()
arr = []
alpha = "ABCDEFGHIJ"
for _ in range(10):
    arr.append([f"{Fore.LIGHTBLACK_EX}[ ]{Fore.RESET}" for _ in range(10)])
treasure = [randint(0, 9), randint(0, 9)]
for a in arr:
    a.insert(0, f"{Fore.BLUE} {arr.index(a)}{Fore.RESET}")


def draw_board():
    print(Fore.YELLOW + "   " + Fore.BLUE + "A   B   C   D   E   F   G   H   I   J")
    for a in arr:
        for n in a:
            if n == "[y]":
                print(f"{Fore.RED}[{Fore.YELLOW}x{Fore.RED}]{Fore.RESET}", end=" ")
            elif n == "[x]":
                print(f"{Fore.BLUE}[{Fore.YELLOW}x{Fore.BLUE}]{Fore.RESET}", end=" ")
            else:
                print(n, end=" ")
        print("")


def unmark():
    for a in arr:
        for n in a:
            if n == "[y]":
                a[a.index(n)] = "[x]"


def mark(x, y):
    unmark()
    x += 1
    arr[y][x] = "[y]"


guesses = 0
while True:
    draw_board()
    guesses += 1
    guess = input(f"Guess where the treasure is (guess {guesses}): ")
    guess = list(guess)
    if guess[0].upper() not in alpha:
        print("Invalid guess")
        continue
    try:
        guess[1] = int(guess[1])
    except Exception:
        print("Invalid guess")
        continue
    guess[0] = alpha.index(guess[0].upper())
    if guess == treasure:
        print(f"You won in {guesses} guesses!")
        break
    else:
        mark(guess[0], guess[1])
