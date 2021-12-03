gate = input("Enter logic gate [A]ND/[O]R/[X]OR/[N]AND/NO[R]: ").upper()
first = input("Enter first input: ")
second = input("Enter second input: ")

if gate == "A":
    if first == 1 and second == 1:
        print(1)
    else:
        print(0)
elif gate == "O":
    if first == 1 or second == 1:
        print(1)
    else:
        print(0)
elif gate == "X":
    if first == second:
        print(0)
    else:
        print(1)
elif gate == "N":
    if first == 1 and second == 1:
        print(0)
    else:
        print(1)
elif gate == "R":
    if first == 1 or second == 1:
        print(0)
    else:
        print(1)
