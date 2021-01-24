open Opium
open Lib

let add_handler req =
  let a = (int_of_string (Request.query_exn "a" req)) in
  let b = (int_of_string (Request.query_exn "b" req)) in
  let add = Math.add a b in
  Lwt.return (Response.of_plain_text (string_of_int add))

let health_check_handler _ =
  Lwt.return (Response.of_plain_text "I'm healthy.")

let run () =
  print_endline "Running server at localhost:3000";
  App.empty
  |> App.get "/" health_check_handler
  |> App.get "/add" add_handler
  |> App.run_command