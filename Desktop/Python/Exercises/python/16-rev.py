import random
from time import sleep

player_num = int(input("Enter a number for the computer to guess: "))
if not 0 < player_num < 101:
    print("That's too high/low, please input between 1 and 100")
    import sys

    sys.exit()
print("The computer will now try to guess your number.\n")
guesses = 0
lowerbound, higherbound = 0, 101

while True:
    sleep(0.2)
    guesses += 1
    guess = random.randint(lowerbound + 1, higherbound - 1)
    if guess == player_num:
        print(f"Computer correctly guessed {player_num}! It took {guesses} guesses.")
        break
    else:
        print(f"Computer guessed {guess}.")
        if guess < player_num:
            print("It was too low.\n")
            lowerbound = guess
        else:
            print("It was too high.\n")
            higherbound = guess
