from random import randint
import sys

suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
numbers = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]

card1 = numbers[randint(0, 12)] + " of " + suits[randint(0, 3)]
card2 = numbers[randint(0, 12)] + " of " + suits[randint(0, 3)]
cards = [card1, card2]
score = numbers.index(card1.split()[0]) + numbers.index(card2.split()[0]) + 2

print("Blackjack\n** It's your turn! **")

while True:
    if score > 21:
        print("You've gone bust!")
        sys.exit()
    elif len(cards) >= 5:
        print("You received 5 cards without going bust, you win!")
        sys.exit()
    print("\nPlayer, your current cards are:")
    for card in cards:
        print(card)
    print(f"...with a score of {score}")
    action = input("Player, do you want to [H]it or [S]tand? ").upper()
    if action != "H" and action != "S":
        print("Sorry, you can only [H]it or [S]tand.")
        continue
    elif action == "H":
        newcard = str(numbers[randint(0, 12)]) + " of " + suits[randint(0, 3)]
        cards.append(newcard)
        score += numbers.index(card1.split()[0]) + 1
        print(f"You drew a card: {newcard}")
        print(f"Your score is now {score}.")
    else:
        print(f"Your final score is {score}!")
        break

card1 = numbers[randint(0, 12)] + " of " + suits[randint(0, 3)]
card2 = numbers[randint(0, 12)] + " of " + suits[randint(0, 3)]
cards = [card1, card2]
playerscore = score
score = numbers.index(card1.split()[0]) + numbers.index(card2.split()[0]) + 2
computer_limit = randint(17, 21)  # When the computer will give up and stop drawing

print("\n** It's the computer's turn! **")

while True:
    if score > 21:
        print("The computer has gone bust, you win!")
        sys.exit()
    elif len(cards) >= 5:
        print("The computer has received 5 cards without going bust, it wins!")
        sys.exit()
    print("\nThe computer's current cards are:")
    for card in cards:
        print(card)
    print(f"...with a score of {score}")
    if score <= computer_limit:
        newcard = str(numbers[randint(0, 12)]) + " of " + suits[randint(0, 3)]
        cards.append(newcard)
        score += numbers.index(card1.split()[0]) + 1
        print(f"It drew a card: {newcard}")
        print(f"Its score is now {score}.")
    else:
        print(f"The computer has decided to Stand, it's final score is {score}!")
        break

print("\n** Summary **")
print("Both players did not go bust!")
print(f"Your score = {playerscore} :: Computer score = {score}")
if playerscore == score:
    print("It was a tie!")
elif playerscore > score:
    print("You win!")
else:
    print("You lost!")
