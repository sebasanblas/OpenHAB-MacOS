//
//  ItemCellView.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 21/05/2021.
//

import Cocoa

class ItemCellView: NSTableCellView {

    @IBOutlet var itemIcon: NSImageView!
    @IBOutlet var itemName: NSTextField!
    @IBOutlet var itemTypeSwitch: NSSwitch!
    @IBOutlet var itemType: NSButton!
    
}
