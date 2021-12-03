use std::io;

fn main() {
    let mut d = String::new();
    let mut t = String::new();

    println!("Enter the distance:");
    io::stdin().read_line(&mut d).expect("Failed to read line");
    println!("Enter the time:");
    io::stdin().read_line(&mut t).expect("Failed to read line");

    let d: i32 = match d.trim().parse() {
        Ok(d) => d,
        Err(_) => 0,
    };

    let t: i32 = match t.trim().parse() {
        Ok(t) => t,
        Err(_) => 0,
    };

    println!("Speed: {}", d / t);
}
