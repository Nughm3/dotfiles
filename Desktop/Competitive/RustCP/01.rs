use std::io;

fn main() {
    let mut i = String::new();
    io::stdin().read_line(&mut i).expect("Failed to read line");
    let mut i: u128 = i.trim().parse().expect("Failed to parse to u128");

    while i != 1 {
        print!("{} ", i);
        i = change(i);
    }
    print!("{}\n", i);
}

fn change(i: u128) -> u128 {
    if i % 2 == 0 {
        i / 2
    } else {
        (i * 3) + 1
    }
}
