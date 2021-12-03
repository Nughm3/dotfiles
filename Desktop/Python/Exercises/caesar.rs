use std::io;
use std::process;

fn main() {
    // Initialize message and shift variables, and the alphabet string
    let mut plaintext = String::new();
    let mut codetext = String::new();
    let mut shift = String::new();
    let alpha = "abcdefghijklmnopqrstuvwxyz";

    // Read the message and shift from stdin
    println!("Enter the message:");
    io::stdin().read_line(&mut plaintext).expect("Failed to read input");
    println!("Enter the shift:");
    io::stdin().read_line(&mut shift).expect("Failed to read input");

    // Convert shift to an integer, and make sure it's under 26
    let shift = match shift.trim().parse::<usize>() {
        Ok(n) => n % 26,
        Err(_) => 0,
    };

    // If the shift was 0 or there was an error parsing shift, exit
    if shift < 1 { process::exit(1); }

    // Encrypt the message
    for c in plaintext.trim().to_lowercase().chars() {
        let index = match alpha.find(c) {
            Some(c) => Some((c + shift) % 26),
            None => None,
        };
        if index == None {
            codetext.push_str(&c.to_string())
        } else {
            codetext.push_str(&alpha.chars().nth(index.unwrap()).unwrap().to_string());
        }
    }

    println!("{}", codetext);
}
