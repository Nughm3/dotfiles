alpha, codetext = "abcdefghijklmnopqrstuvwxyz", ""
mode = input("[E]ncrypt/[D]ecrypt? ").upper()
message = input("Enter the message: ")
seed = int(input("Enter the seed: "))
seed = list(str(seed))
for char in range(len(message)):
    if message[char] not in alpha:
        print(message[char], end="")
    else:
        index = alpha.index(message[char])
        if mode == "E":
            index += int(seed[char])
            index %= 26
        elif mode == "D":
            index -= int(seed[char])
            index %= 26
        else:
            print("Invalid mode")
            break
        print(alpha[index], end="")
print("\n")
