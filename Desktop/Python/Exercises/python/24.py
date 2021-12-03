game = {
    "HomeTeam": 10,
    "AwayTeam": 12,
}

while True:
    action = input("What to do? [A]dd/[S]earch ").upper()
    if action == "A":
        resultName = input("Add a team: ")
        resultScore = input("The team's score: ")
        game[resultName] = int(resultScore)
    elif action == "S":
        query = input("Search for a team: ")
        if query not in game:
            print("Query not found")
        else:
            print(query + ": " + str(game[query]))
