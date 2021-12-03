def calc_grade(percent):
    if percent >= 80:
        return "A"
    elif percent >= 70:
        return "B"
    elif percent >= 60:
        return "C"
    elif percent >= 50:
        return "D"
    elif percent >= 40:
        return "E"
    elif percent >= 30:
        return "F"
    elif percent >= 20:
        return "G"
    elif percent >= 10:
        return "H"


m1 = int(input("Enter % for Module 1: "))
m2 = int(input("Enter % for Module 2: "))

print("Module 1:", calc_grade(m1))
print("Module 2:", calc_grade(m2))
print("Overall:", calc_grade((m1 + m2) // 2))
