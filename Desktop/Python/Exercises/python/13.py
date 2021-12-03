from random import randint


n = randint(20, 30)
while True:
    print(f"Current number: {n}")
    rm = int(input("How much do you want to remove? "))
    if 1 > rm > 3:
        print("You can only remove 1-3")
        continue
    n -= rm
    if n < 1:
        print("You lost!")
        break
    crm = randint(1, 3)
    print(f"Computer removed {crm}")
    n -= crm
    if n < 1:
        print("Computer lost!")
        break
