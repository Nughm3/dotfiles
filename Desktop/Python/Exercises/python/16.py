from random import randint

secret_num = randint(1, 100)
guesses = 0
while True:
    guesses += 1
    guess = int(input("Guess a number: "))
    if guess == secret_num:
        print(f"You guessed the number in {guesses} guesses!")
        break
    elif guess < secret_num:
        print("Guess higher")
    else:
        print("Guess lower")
