names, already, duplicate = [], [], []
ui = ""

while ui != "exit":
    ui = input("Enter a name: ")
    names.append(ui)
names.remove("exit")

for name in names:
    if name not in already:
        already.append(name)
    else:
        duplicate.append(name)

for name in duplicate:
    print(name)
