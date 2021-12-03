use std::{env::args, fs, io::Result, path::Path};

fn main() -> Result<()> {
    let args: Vec<String> = args().into_iter().skip(1).take(2).collect();
    let file1 = Path::new(&args[0]);
    let file2 = Path::new(&args[1]);

    if file1.exists() && file2.exists() {
        fs::rename(file1, "temp_file")?;
        fs::rename(file2, file1)?;
        fs::rename("temp_file", file2)?;
    }

    Ok(())
}
