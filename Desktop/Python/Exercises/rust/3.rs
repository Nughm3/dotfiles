use std::io;

fn main() {
    let mut a = String::new();
    let mut b = String::new();
    println!("Enter width:");
    io::stdin().read_line(&mut a).expect("Failed to read line");
    println!("Enter height:");
    io::stdin().read_line(&mut b).expect("Failed to read line");

    let a: i32 = match a.trim().parse() {
        Ok(a) => a,
        Err(_) => 0,
    };
    let b: i32 = match b.trim().parse() {
        Ok(b) => b,
        Err(_) => 0,
    };
    
    println!("Area: {}", a * b);
}
