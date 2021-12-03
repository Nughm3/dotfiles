n = int(input())
for i in range(n // 2):
    if n % (i + 1) == 0 and i != 0:
        print(i + 1)
