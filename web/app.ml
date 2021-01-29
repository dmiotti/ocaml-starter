open Opium
open Lib

let bad_request_response (reason : string) =
  Response.of_plain_text reason |> Response.set_status `Bad_request

let add_handler req =
    try
        let a = Request.query_exn "a" req in
        let b = Request.query_exn "b" req in
        let result = Math.add (int_of_string a) (int_of_string b) in
        Lwt.return (Response.of_plain_text (string_of_int result))
    with Invalid_argument(error) -> Lwt.return (bad_request_response error)

let health_check_handler _ = Lwt.return (Response.of_plain_text "I'm healthy.")

let run () =
  print_endline "Running server at localhost:3000";
  App.empty
  |> App.get "/" health_check_handler
  |> App.get "/add" add_handler |> App.run_command
