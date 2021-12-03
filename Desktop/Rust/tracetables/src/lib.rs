extern crate proc_macro;
use proc_macro::TokenStream;
use quote::{quote, ToTokens};
use syn::fold::{self, Fold};
use syn::{parse_macro_input, parse_quote, Expr, Ident, ItemFn, Local, Pat, Stmt, Token};

/// Contains the implementation of a trace table, by row
mod table;

/// When applied to a function, `#[trace]` will output a trace table after execution  
/// Trace tables contain information such as:
///  - Line numbers and file names
///  - Variables, arrays/vectors and their values
///  - Standard input, output and error
///  - Debug information when the `dbg!()` macro is invoked
#[proc_macro_attribute]
pub fn trace(_args: TokenStream, input: TokenStream) -> TokenStream {
    let mut table = table::TraceTable::new(file!());

    todo!()
}
