//
//  DeleteViewController.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 22/05/2021.
//

import Cocoa

class DeleteViewController: NSViewController {

    @IBOutlet var itemSelected: NSComboBox!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSelected.addItems(withObjectValues: UserDefaultsManagement.itemsToShow )
    }

    @IBAction func deleteItem(_ sender: Any) {
        if let index = UserDefaultsManagement.itemsToShow.firstIndex(of: itemSelected.stringValue) {
            UserDefaultsManagement.itemsToShow.remove(at: index)
        }
        UserDefaultsManagement.iconDicc.removeValue(forKey: itemSelected.stringValue)
        UserDefaultsManagement.itemTypeDicc.removeValue(forKey: itemSelected.stringValue)
        UserDefaultsManagement.itemNameDicc.removeValue(forKey: itemSelected.stringValue)
        itemSelected.removeAllItems()
        itemSelected.addItems(withObjectValues: UserDefaultsManagement.itemsToShow )

        #if DEBUG
            print(UserDefaultsManagement.itemsToShow)
        print(UserDefaultsManagement.iconDicc)
        print(UserDefaultsManagement.itemTypeDicc)
        print(UserDefaultsManagement.itemNameDicc)
        #endif
    }

}
