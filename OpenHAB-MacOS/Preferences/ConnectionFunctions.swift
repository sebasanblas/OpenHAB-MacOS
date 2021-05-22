//
//  ConnectionFunctions.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 21/05/2021.
//

import Foundation
import os.log

class InternetConnection {

    // MARK: - Status Network Function
    func statusNetwork(inputURL: String) -> Bool {

        var status: Bool = false
        let url = NSURL(string: inputURL)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        var response: URLResponse?
            do {
                _ = try NSURLConnection
                    .sendSynchronousRequest(request as URLRequest, returning: &response) as NSData?
            } catch let error as NSError {
                os_log("Please check the internet connection", log: defaultLog, type: .error)
                print(error.localizedDescription)
                return status
            }
        if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    status = true
                }
            }
            return status
       }
    // MARK: - Is JSON? Function
    func isJSON(inputURL: String) -> Bool {

        var status: Bool = false
        let url = NSURL(string: inputURL)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        var response: URLResponse?
            do {
                _ = try NSURLConnection
                    .sendSynchronousRequest(request as URLRequest, returning: &response) as NSData?
            } catch let error as NSError {
                os_log("Please check the URL entered. Does not contain a JSON file", log: defaultLog, type: .error)
                print(error.localizedDescription)
            }
        if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.value(forHTTPHeaderField: "Content-Type")! == "application/json" {
                    status = true
                }
            }
            return status
       }

    // MARK: - Check URL Function
    func checkURL(localURLInput: String, externalURLInput: String) -> (status: String, URLOutput: String) {
        if statusNetwork(inputURL: localURLInput) == true && isJSON(inputURL: localURLInput) == true {
            return (status: "Connected", URLOutput: localURLInput)
        } else if statusNetwork(inputURL: externalURLInput) == true && isJSON(inputURL: externalURLInput) == true {
            return (status: "Connected", URLOutput: externalURLInput)
        } else if (statusNetwork(inputURL: externalURLInput) ||
                    statusNetwork(inputURL: localURLInput)) == true &&
                    (isJSON(inputURL: externalURLInput) || isJSON(inputURL: localURLInput)) == false {
            os_log("Problems getting the JSON file", log: defaultLog, type: .error)
            return (status: "Caution", URLOutput: "")
        } else {
            os_log("Connection failed", log: defaultLog, type: .error)
            return (status: "Disconnected", URLOutput: "")
        }
    }
    // MARK: - General Connection
    func checkConnection(_ url: Bool) {
        if url == true {
            if UserDefaultsManagement.urlToUse == "" {
                os_log("URL empty, please check the URL entered", log: defaultLog, type: .default)
                UserDefaultsManagement.statusIcon = "NSStatusUnavailable"
                UserDefaultsManagement.connectionOkey = false
            } else {
                let output = checkURL(localURLInput: UserDefaultsManagement.localURL,
                                      externalURLInput: UserDefaultsManagement.localURL)
                if output.status == "Connected" {
                    os_log("Established connection", log: defaultLog, type: .info)
                    UserDefaultsManagement.urlToUse = output.URLOutput
                    UserDefaultsManagement.statusIcon = "NSStatusAvailable"
                    UserDefaultsManagement.connectionOkey = true
                } else if output.status == "Disconnected" || output.status == "Caution" {
                    os_log("Connection failed", log: defaultLog, type: .error)
                    UserDefaultsManagement.urlToUse = ""
                    UserDefaultsManagement.statusIcon = "NSStatusUnavailable"
                    UserDefaultsManagement.connectionOkey = false
                }
            }
        } else if url == false {
            let output = checkURL(localURLInput: UserDefaultsManagement.localURL,
                                  externalURLInput: UserDefaultsManagement.localURL)
            if output.status == "Connected" {
                os_log("Established connection", log: defaultLog, type: .info)
                UserDefaultsManagement.urlToUse = output.URLOutput
                UserDefaultsManagement.statusIcon = "NSStatusAvailable"
                UserDefaultsManagement.connectionOkey = true
            } else if output.status == "Disconnected" || output.status == "Caution" {
                os_log("Connection failed", log: defaultLog, type: .error)
                UserDefaultsManagement.urlToUse = ""
                UserDefaultsManagement.statusIcon = "NSStatusUnavailable"
                UserDefaultsManagement.connectionOkey = false
            }
        }
    }
}
