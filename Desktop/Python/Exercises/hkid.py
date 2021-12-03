#!/usr/bin/python3

ALPHA = "abcdefghijklmnopqrstuvwxyz"

def main(id):
    if len(id) != 8:
        return False
    head = ALPHA.index(id[0].lower()) + 1
    if id[-1] in ALPHA:
        check = ALPHA.index(id[-1].lower()) + 1
    else:
        check = id[-1]
    new_id = str(head) + id[1:-1]
    list_id = []

    print(f"Verifying ID {fmt(id)}")

    for idx, v in enumerate(range(8, 1, -1)):
        list_id.append(int(new_id[idx]) * v)

    sum_id = sum(list_id)
    sum_id = sum_id % 11
    final = 11 - sum_id
    
    if final < 10:
        return final == int(check)
    elif final == 10:
        return final == 1
    elif final == 11:
        return int(check) == 0

def fmt(id):
    return id[:-2].upper() + f"({str(id[-1]).upper()})"

if __name__ == "__main__":
    id = input("Enter ID number: ")
    result = main(id)
    if result:
        print(f"ID {fmt(id)} is valid")
    else:
        print(f"ID {fmt(id)} is invalid")
