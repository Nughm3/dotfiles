use std::io;

fn main() {
    let mut temp = String::new();

    println!("Why do most programmers prefer dark mode?");
    io::stdin().read_line(&mut temp).expect("Failed to read line");
    println!("Because the light attracts bugs.\n");

    println!("What do you call a programmer that doesn't use Stack Overflow?");
    io::stdin().read_line(&mut temp).expect("Failed to read line");
    println!("A liar.");

    println!("\nSource: https://upjoke.com/programmer-jokes");
}
