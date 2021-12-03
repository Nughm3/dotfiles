open System

let greet name =
    sprintf "Hello %s" name

[<EntryPoint>]
let main argv =
    let mutable sum = 0
    printfn "The sum is %i" sum
    0
