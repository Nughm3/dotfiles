from random import randint


num_list = []
count = 10
while count > 0:
    randnum = randint(1, 13)
    if randnum not in num_list:
        num_list.append(randnum)
        count -= 1

for n in num_list:
    print(n, end=", ")

for n in range(10):
    print("\nCurrent number is", num_list[n])
    guess = input("Guess [H]igher or [L]ower: ").upper()
    if n == 9:
        print("You win!")
        break
    if guess == "H":
        if num_list[n] < num_list[n + 1]:
            continue
        else:
            print("Incorrect")
            break
    elif guess == "L":
        if num_list[n] > num_list[n + 1]:
            continue
        else:
            print("Incorrect")
            break
    else:
        break
