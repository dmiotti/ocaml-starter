open Lib

let () = 
  print_endline "Hello, world!";
  let result = Math.add 3 2 in
  print_endline (string_of_int result)
