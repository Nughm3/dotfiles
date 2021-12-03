from datetime import datetime

birthday, now = datetime.strptime(input("Enter birthday: "), "%Y-%m-%d"), datetime.now()
print(abs((now - birthday).days), "days")
