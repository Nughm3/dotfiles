use std::io;
use std::time::Instant;

fn main() {
    let mut temp = String::new();

    println!("Hit ENTER when ready");
    io::stdin().read_line(&mut temp).expect("Failed to read line");
    println!("Hit ENTER again to stop");
    let start = Instant::now();
    io::stdin().read_line(&mut temp).expect("Failed to read line");
    let duration = start.elapsed();
    println!("Time elapsed: {:?}", duration);
}
