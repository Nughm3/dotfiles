def drawstars(spaces, stars):
    return " " * spaces + "*" * stars


print(drawstars(2, 3))
print(drawstars(2, 3))
print(drawstars(3, 1))
print(drawstars(2, 3))
print(drawstars(0, 7))
print(drawstars(2, 3))
print(drawstars(2, 1) + drawstars(1, 1))
print(drawstars(1, 2) + drawstars(1, 2))

# warning: JetBrains Mono font renders *** differently due to a ligature
print("---")
base = int(input("Enter base size (odd): "))


def pyramid(base):
    if base % 2 == 0:
        print("Nope.")
        return
    for n in range(base + 2):
        if n % 2 == 0:
            continue
        print(drawstars((base - n) // 2, n))


pyramid(base)
