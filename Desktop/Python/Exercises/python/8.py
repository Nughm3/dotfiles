from datetime import datetime

bd = datetime.strptime(input("Enter birthday: "), "%Y-%m-%d")
now = datetime.now()
diff = abs(now - bd).days
if diff > 6574.5:
    print("You are old enough to vote")
else:
    print("You aren't old enough to vote")
