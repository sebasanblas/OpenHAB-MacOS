//
//  AddViewController.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 22/05/2021.
//

import Cocoa

class AddViewController: NSViewController {

    var mainFunctions = MainFunctions()
    var iconAvailable = ["battery", "blinds", "camera", "door", "frontdoor",
                         "garagedoor", "lawnmower", "lightbulb", "lock",
                         "poweroutlet", "projector", "receiver", "siren", "wallswitch",
                         "whitegood", "window", "switch", "text", "rollershutter",
                         "group", "colorpicker", "humidity", "moon", "rain", "snow",
                         "sun", "sun_clouds", "temperature", "wind", "batterylevel",
                         "carbondioxide", "energy", "fire", "flow", "gas", "lowbattery",
                         "motion", "oil", "pressure", "price", "qualityofservice",
                         "smoke", "soundvolume", "temperature", "time", "water", "error",
                         "bluetooth", "faucet"]

    @IBOutlet var itemSelected: NSComboBox!
    @IBOutlet var itemNameDefined: NSTextField!
    @IBOutlet var iconSelected: NSComboBox!
    @IBOutlet var iconSelectedImage: NSImageView!
    @IBOutlet var itemTypeSelected: NSComboBox!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSelected.addItems(withObjectValues: itemsAvailable)
        iconSelected.addItems(withObjectValues: iconAvailable)
        itemTypeSelected.addItems(withObjectValues: itemType)
    }

    @IBAction func iconSelectedShow(_ sender: Any) {
        iconSelectedImage.image = NSImage(named: iconSelected.stringValue)
    }

    @IBAction func saveItem(_ sender: Any) {
        UserDefaultsManagement.itemsToShow.append(itemSelected.stringValue)
        if itemNameDefined.stringValue == "" {
            UserDefaultsManagement.itemNameDicc[itemSelected.stringValue] = itemSelected.stringValue
        } else {
            UserDefaultsManagement.itemNameDicc[itemSelected.stringValue] = itemNameDefined.stringValue
        }
        if iconSelected.stringValue == "" {
            UserDefaultsManagement.iconDicc[itemSelected.stringValue] = "text"
        } else {
            UserDefaultsManagement.iconDicc[itemSelected.stringValue] = iconSelected.stringValue }

        if itemTypeSelected.stringValue == "" {
            UserDefaultsManagement.itemTypeDicc[itemSelected.stringValue] = "Label"
        } else {
            UserDefaultsManagement.itemTypeDicc[itemSelected.stringValue] = itemTypeSelected.stringValue }

        #if DEBUG
            print(UserDefaultsManagement.itemsToShow)
            print(UserDefaultsManagement.iconDicc)
            print(UserDefaultsManagement.itemTypeDicc)
            print(UserDefaultsManagement.itemNameDicc)
        #endif
    }

}
