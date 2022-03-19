import Swifter

func main() {
  let server = HttpServer()
  server["/hello"] = { .ok(.htmlBody("You asked for \($0)"))  }
  try! server.start()
}

main()