use super::*;
use std::fmt;

#[derive(Debug)]
struct Row {
    line: u32,
    variables: Vec<Option<Ident>>,
    stdin: Option<String>,
    stdout: Option<String>,
    stderr: Option<String>,
    dbg: Option<String>,
}

impl Row {
    fn new(line: u32) -> Self {
        Row {
            line,
            variables: Vec::new(),
            stdin: None,
            stdout: None,
            stderr: None,
            dbg: None,
        }
    }
}

#[derive(Debug)]
pub struct TraceTable {
    pub file: &'static str,
    pub variables: Vec<Ident>,
    pub table: Vec<Row>,
}

impl TraceTable {
    pub fn new(file: &'static str) -> Self {
        TraceTable {
            file,
            variables: Vec::new(),
            table: Vec::new(),
        }
    }
}

impl fmt::Display for TraceTable {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        writeln!(f, "\n{:?}", self)?;
        Ok(())
    }
}
