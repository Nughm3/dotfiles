use std::io;
use std::error::Error;

fn main() {
    let mut a = String::new();
    let mut b = String::new();
    let mut gate = String::new();

    io::stdin().read_line(&mut a).expect("Failed to read line");
    io::stdin().read_line(&mut b).expect("Failed to read line");
    println!("Enter gate:");
    io::stdin().read_line(&mut gate).expect("Failed to read line");

    let a = a as u8;
    let b = b as u8;

    println!("Result: {}", match gate {
        "A" => if a == 1 && b == 1 {"1"} else {"0"},
        "O" => if a == 1 || b == 1 {"1"} else {"0"},
        "X" => if a == b {"0"} else {"1"},
        "N" => if a == 0 && b == 0 {"1"} else {"0"},
        "R" => if a == 0 || b == 0 {"1"} else {"0"},
    });
}
