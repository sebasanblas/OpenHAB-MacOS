//
//  ViewController.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 21/05/2021.
//

import Cocoa

class MainViewController: NSViewController {

    var mainFunctions = MainFunctions()
    var internetConnection = InternetConnection()
    var director: [Item]?

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var statusIconMain: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        internetConnection.checkConnection(true)
        statusIconMain.image = NSImage(named: UserDefaultsManagement.statusIcon)
        if UserDefaultsManagement.connectionOkey == false {
            print("No se pudo concretar la conexión")
        } else {
            print("Conexión exitosa")
            itemsAvailable = mainFunctions.obteinItemAvailable(UserDefaultsManagement.urlToUse)
        }
        generalTimer()
    }

    func generalTimer() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self,
                             selector: #selector(general), userInfo: nil, repeats: true)
    }

    @objc func general() {
        self.tableView.reloadData()
        internetConnection.checkConnection(true)
        if UserDefaultsManagement.connectionOkey == false {
            statusIconMain.image = NSImage(named: UserDefaultsManagement.statusIcon)
            print("No se pudo concretar la conexión")
        } else {
            statusIconMain.image = NSImage(named: UserDefaultsManagement.statusIcon)
            print("Conexión exitosa")
            itemsAvailable = mainFunctions.obteinItemAvailable(UserDefaultsManagement.urlToUse)
            DispatchQueue.main.async {
                self.mainFunctions.loadData(urlString: UserDefaultsManagement.urlToUse,
                                            arrayInput: UserDefaultsManagement.itemsToShow) {users in
                self.director = users
                }
            }
        }
    }
}
extension MainViewController: NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    #if DEBUG
        print("Total Elements: \(mainFunctions.purchasesNew.count)")
    #endif
    return mainFunctions.purchasesNew.count
  }

}

extension MainViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let itemCell = tableView.makeView(withIdentifier:
                            NSUserInterfaceItemIdentifier(rawValue: "itemCell"), owner: self)
                            as? ItemCellView else { return nil }

        // Icon
        let iconToUse = UserDefaultsManagement.iconDicc[(director?[row].name)!]
        itemCell.itemIcon.image = NSImage(named: iconToUse ?? "text")

        // Label
        if director?[row].label == nil {
            let nameToUse = UserDefaultsManagement.itemNameDicc[(director?[row].name)!]
            itemCell.itemName.stringValue = nameToUse ?? "N/A"
        } else {
        itemCell.itemName.stringValue = director?[row].label ?? "N/A"
        }
        // Type
        let type = UserDefaultsManagement.itemTypeDicc[(director?[row].name)!]

        if type == "Label" {
            itemCell.itemTypeSwitch.isHidden = true
            itemCell.itemType.isHidden = false
            itemCell.itemType.setButtonType(.onOff)
            itemCell.itemType.title = director?[row].state ?? "NULL"
        } else if type == "Switch" {
            itemCell.itemTypeSwitch.isHidden = false
            itemCell.itemType.isHidden = true
            if director?[row].state == "ON" {
                itemCell.itemTypeSwitch.state = .on
            } else if director?[row].state == "OFF" {
                itemCell.itemTypeSwitch.state = .off
            }
        }
        return itemCell
    }

}
