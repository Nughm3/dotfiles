alpha = "abcdefghijklmnopqrstuvwxyz"
from datetime import datetime

input("Hit ENTER when ready ")
seconds1 = datetime.now().second
useralpha = input()
seconds2 = datetime.now().second

if useralpha == alpha:
    print(seconds2 - seconds1)
else:
    print("You got it wrong, try again")
