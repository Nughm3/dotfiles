from random import randint

code = []
for _ in range(4):
    code.append(randint(0, 9))
guesses = 0
while guesses <= 12:
    guess = input()
    guess_digits = []
    for n in range(len(str(guess))):
        guess_digits.append(int(guess[n]))
    guesses += 1
    correct = 0
    if guess_digits == code:
        print(f"You won in {guesses} guesses!")
        break
    else:
        for n in range(len(guess_digits)):
            if guess_digits[n] == code[n]:
                correct += 1
        print(f"That's not the code, but you got {correct} digits correct")
if guesses > 12:
    print("You lost!")
