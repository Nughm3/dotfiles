#!/usr/bin/python
alpha, codetext = "abcdefghijklmnopqrstuvwxyz", ""
message = input("Enter the message: ")
shift = int(input("Enter the shift: ")); shift %= 26
for char in range(len(message)):
    if message[char] not in alpha:
        print(message[char], end="")
    else:
        index = alpha.index(message[char])
        index += shift; index %= 26
        print(alpha[index], end="")
print("\n")
