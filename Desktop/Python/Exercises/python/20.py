n = int(input("Which term? "))

fib = [0, 1]

for _ in range(n - 1):
    fib.append(fib[-2] + fib[-1])
print(fib[-1])
