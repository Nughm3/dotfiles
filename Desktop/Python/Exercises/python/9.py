from random import randint

suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
numbers = ["Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King"]

while True:
    card = input(str(numbers[randint(0, 12)]) + " of " + suits[randint(0, 3)])
