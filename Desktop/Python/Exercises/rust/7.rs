use std::{io, time::Instant};

fn main() {
    let mut alpha = String::new();
    println!("Hit ENTER when ready");
    io::stdin().read_line(&mut alpha).expect("Failed to read line");
    let start = Instant::now();
    println!("Type the alphabet!");
    io::stdin().read_line(&mut alpha).expect("Failed to read line");
    if alpha.trim() == String::from("abcdefghijklmnopqrstuvwxyz") {
        println!("Correctly typed alphabet in {:?}", start.elapsed());
    } else {
        println!("You didn't type the alphabet correctly")
    }
}
