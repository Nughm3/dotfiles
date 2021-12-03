from random import randint

print("Rock Paper Scissors")
actions = ["R", "P", "S", "Q"]
while True:
    action = input("\nSelect [R]ock/[P]aper/[S]cissors/[Q]uit: ").upper()
    if action not in actions:
        print(f"Not a valid option: {action}")
        continue
    elif action != "Q":
        computer_action = actions[randint(0, 2)]
        print(f"You chose: {action}\nComputer chose: {computer_action}")
        if action == "R":
            if computer_action == "R":
                print("This round is a tie!")
            elif computer_action == "P":
                print("Computer wins this round!")
            else:
                print("You win this round!")
        elif action == "P":
            if computer_action == "R":
                print("You win this round!")
            elif computer_action == "P":
                print("This round is a tie!")
            else:
                print("Computer wins this round!")
        else:
            if computer_action == "R":
                print("Computer wins this round!")
            elif computer_action == "P":
                print("You win this round!")
            else:
                print("This round is a tie!")
    else:
        break
