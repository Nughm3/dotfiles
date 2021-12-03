from getpass import getpass

secret_word = getpass(prompt="P1, please enter the secret word: ").upper()
lives = int(input("P1, how many lives will you grant P2? "))
guess = list("*" * len(secret_word))
player2won = False

for n in range(lives):
    if player2won:
        break
    for g in guess:
        print(g, end="")
    letter = input("\nP2, please guess a letter: ").upper()
    if len(letter) != 1:
        print("Guess only 1 letter at a time")
        continue
    count = 0
    for s in list(secret_word):
        if s != "*":
            if letter == s:
                guess[count] = letter
        else:
            guess[count] = "*"
        count += 1
        if guess == list(secret_word):
            print(f"P2 guessed the word, {secret_word}")
            player2won = True
            break
