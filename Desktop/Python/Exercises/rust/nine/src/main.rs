use rand::{Rng, thread_rng};
use std::io;

fn main() {
    let suits = ["Spades", "Hearts", "Clubs", "Diamonds"];
    let numbers = ["Ace", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"];
    let mut temp = String::new();
    loop {
        io::stdin().read_line(&mut temp).expect("Failed to read line");
        let suit = suits[thread_rng().gen_range(0..4)];
        let num = numbers[thread_rng().gen_range(0..13)];
        println!("{} of {}", num, suit);
    }
}
