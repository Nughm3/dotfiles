use std::io;

fn main() {
    let mut n = String::new();
    io::stdin().read_line(&mut n).expect("Failed to read line");
    let n: u128 = n.trim().parse().expect("Failed to parse string");

    let mut v = vec![];

    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read line");
    for i in input.split_whitespace() {
        let x: u128 = i.trim().parse().expect("Failed to parse string");
        v.push(x);
    }

    v.sort();
    let mut ans = None;

    for (i, v) in v.iter().enumerate() {
        if (i + 1) as u128 != *v {
            ans = Some(v - 1);
            break;
        }
    }
    if let Some(x) = ans {
        println!("{}", x);
    } else {
        println!("{}", n);
    }
}
