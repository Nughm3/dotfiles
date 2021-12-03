from uuid import uuid1 as uuid
from pyperclip import copy

while True:
    id = str(uuid())
    copy(id)
    print(f"Copied ID to clipboard: {id}")
    input()
