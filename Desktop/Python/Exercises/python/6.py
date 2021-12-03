from datetime import datetime

input("Hit ENTER when you are ready ")
second1 = datetime.now().second
input("Hit ENTER again to stop...")
second2 = datetime.now().second

print(second2 - second1)
