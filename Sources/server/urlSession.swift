import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

func useSession() {
  let url = URL(string: "https://swift.org")!

  var request = URLRequest(url: url)
  request.httpMethod = "GET"

  let task = URLSession.shared.dataTask(with: request) {(data, response, error) in 
    print("Response...")
    if let error = error {
      print("ERROR: \(error)")
      return
    }

    guard let data = data else { return print("Data empty") }
    print(String(data: data, encoding: .utf8)!)
  }

  print("Launch TASK")
  task.resume()
  print("Task launched")

  while(true) {

  }
}

//useSession()