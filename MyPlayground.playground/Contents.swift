//: Playground - noun: a place where people can play
import UIKit
import PlaygroundSupport
import SwiftyJSON

// Set up the URL request
func makeGetCall() {
    
    // Set up the URL request
    let approvalRequestsEndpoint: String = "http://192.168.1.34:8080/ApprovalRequests/requests/pending/ydaoudi"
    guard let url = URL(string: approvalRequestsEndpoint) else {
        print("Error: cannot create URL")
        return
    }
    let urlRequest = URLRequest(url: url)
    
    // set up the session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    // make the request
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        
        guard error == nil else {
            print("error calling GET on \(approvalRequestsEndpoint)")
            print(error!)
            return
        }
        
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        
        do {
            guard let res = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
            }
            
            guard let res_data = res["data"] as? [[String: Any]] else{
                print("error trying to get data from JSON OBJECT")
                return
            }
            
            for item in res_data {
                guard let wpJsonDescription = item["wpJsonDescription"] as? String else { return }
                print(wpJsonDescription)
                print("------")
            }
            
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
    }
    task.resume()
}

makeGetCall()

PlaygroundPage.current.needsIndefiniteExecution = true
