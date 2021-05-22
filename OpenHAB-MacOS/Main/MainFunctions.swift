//
//  MainFunctions.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 21/05/2021.
//

import Foundation
import SwiftyJSON

struct Item: Codable {
    var name: String
    var state: String
    var label: String?
}

typealias Date = [Item]

class MainFunctions {

    var purchasesNew = [Item]()

    // Function that returns all available items in the form of an array.
    func obteinItemAvailable(_ urlString: String) -> [String] {
        var itemsArray: [String] = Array()
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOf: url as URL, options: []) {
                do {
                    let json = try JSON(data: data as Data)
                    let arrayCount = json.array?.count ?? 0
                    for values in 0..<arrayCount {
                        let itemName = json[values]["name"].string ?? "N/A"
                        itemsArray.append(itemName)
                    }
                } catch {
                    print("error")
                }
            }
        }
        return itemsArray
    }

    // Function that returns the data structure, with the values of each item.
    func loadData(urlString: String, arrayInput: [String], completion: @escaping (Date) -> Void) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error as NSError?, error.domain == NSURLErrorDomain,
               error.code == NSURLErrorNotConnectedToInternet {
                print("Error")
                return
            }
            do {
                let items = try JSONDecoder().decode([Item].self, from: data!)
                self.purchasesNew = items.filter({ arrayInput.contains($0.name)})
                completion(self.purchasesNew)
            } catch {
                print(error)
            }
        }.resume()
    }

}
