use regex::Regex;
use std::{env, error::Error, fs, path::Path, process::exit};

fn main() -> Result<(), Box<dyn Error>> {
    let mut words_file = String::new();
    if let Ok(f) = env::var("WORDS_FILE") {
        words_file = f;
    } else if Path::new("/usr/share/dict/words").exists() {
        words_file = "/usr/share/dict/words".to_owned();
    } else if Path::new("/usr/dict/words").exists() {
        words_file = "/usr/dict/words".to_owned();
    } else {
        eprintln!("Couldn't find words file at /usr/share/dict/words or /usr/dict/words");
    }

    if let Some(query) = env::args().nth(1) {
        let re = Regex::new(&query)?;
        let words = fs::read_to_string(words_file)?;
        for word in words.lines() {
            if re.is_match(word) {
                println!("{}", word);
            }
        }
    } else {
        eprintln!("Please provide a query");
        exit(1);
    }
    Ok(())
}
