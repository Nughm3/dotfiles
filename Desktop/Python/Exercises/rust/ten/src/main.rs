use rand::{Rng, thread_rng};
use std::io;

fn main() {
    loop {
        println!("Select [R]ock/[P]aper/[S]cissors:");
        let mut action = String::new();
        io::stdin().read_line(&mut action).expect("Failed to read line");
        action = action.to_uppercase();
        
        let computer_action: &str = match thread_rng().gen_range(0..3) {
            0 => "R",
            1 => "P",
            _ => "S",
        };

        println!("Player chose {}, computer chose {}", action, computer_action);
        println!("This round was {}!", determine_winner(&action, &computer_action));
    }
}

enum GameResult {
    Tie,
    Player,
    Computer,
}

impl std::fmt::Display for GameResult {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            &Self::Tie => write!(f, "a tie"),
            &Self::Player => write!(f, "won by the player"),
            &Self::Computer => write!(f, "a tie"),
        }
    }
}

fn determine_winner(player: &str, computer: &str) -> GameResult {
    match player {
        "R" => match computer { "R" => GameResult::Tie, "P" => GameResult::Computer, _ => GameResult::Player },
        "P" => match computer { "R" => GameResult::Player, "P" => GameResult::Tie, _ => GameResult::Computer },
        _ => match computer { "R" => GameResult::Computer, "P" => GameResult::Player, _ => GameResult::Tie },
    }
}
