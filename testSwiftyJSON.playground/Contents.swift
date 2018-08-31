//: Playground - noun: a place where people can play
import UIKit
import PlaygroundSupport
import SwiftyJSON

// Set up the URL request
func makeGetCall() {
    
    // Set up the URL request
    let approvalRequestsEndpoint: String = "http://192.168.1.24:8080/requests/pending/ydaoudi"
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
        
        let res = JSON(responseData)
        let wpJsonDescriptionString = res["data"][0]["wpJsonDescription"].string
        print(wpJsonDescriptionString!)
        guard let dataFromWpJsonDescriptionString = wpJsonDescriptionString?.data(using: String.Encoding.utf8, allowLossyConversion: false)! else{return}
        let wpJsonDescription = JSON(dataFromWpJsonDescriptionString)
        print(wpJsonDescription)
        
    }
    task.resume()
}

makeGetCall()

PlaygroundPage.current.needsIndefiniteExecution = true
