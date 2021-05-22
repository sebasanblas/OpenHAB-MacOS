//
//  PreferencesViewController.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 21/05/2021.
//

import Cocoa

class PreferencesViewController: NSViewController {

    // MARK: - Variables
    let internetConnection = InternetConnection()

    // MARK: - Interface Builder
    @IBOutlet var localURLField: NSTextField!
    @IBOutlet var statusIcon: NSImageView!
    @IBAction func connectionButton(_ sender: Any) {
        UserDefaultsManagement.localURL = "http://\(localURLField.stringValue)/rest/items"
        internetConnection.checkConnection(false)
        statusIcon.image = NSImage(named: UserDefaultsManagement.statusIcon)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        localURLField.stringValue = String(UserDefaultsManagement.localURL)
        statusIcon.image = NSImage(named: UserDefaultsManagement.statusIcon)
    }

}
