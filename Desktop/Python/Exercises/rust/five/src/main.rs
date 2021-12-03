use chrono::prelude::*;
use std::io;

fn main() {
    let mut bd = String::new();

    println!("Enter your birthday:");
    io::stdin().read_line(&mut bd).expect("Failed to read line");

    let bd = NaiveDate::parse_from_str(&bd.trim(), "%Y-%m-%d").unwrap();
    let now = Local::now();

    println!("Birthday: {:?}", diff);
}
