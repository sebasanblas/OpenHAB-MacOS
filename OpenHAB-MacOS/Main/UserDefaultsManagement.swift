//
//  UserDefaultsManagement.swift
//  OpenHAB-MacOS
//
//  Created by Sebastian San Blas on 21/05/2021.
//

import Foundation
import os.log

public var itemsAvailable: [String] = Array()

public var itemType = ["Label", "Switch"]

public let defaultLog = OSLog(subsystem: "com.oh", category: "OpenHAB MacOS")

public class UserDefaultsManagement {

    public static var shared: UserDefaults? = UserDefaults.standard

    private struct Constants {
        static let LocalURL = "localURL"
        static let StatusIcon = "statusIcon"
        static let URLToUse = "urlToUse"
        static let ConnectionOkey = "connectionOkey"
        static let ItemToShow = "itemsToShow"
        static let IconDicc = "iconDicc"
        static let ItemTypeDicc = "itemTypeDicc"
        static let ItemNameDicc = "itemNameDicc"
    }

    static var localURL: String {
        get {
            if let url = shared?.object(forKey: Constants.LocalURL) as? String {
                return url
            }
            return String()
        }
        set {
            shared?.set(newValue, forKey: Constants.LocalURL)
            }
        }
    static var urlToUse: String {
        get {
            if let url = shared?.object(forKey: Constants.URLToUse) as? String {
                return url
            }
            return ""
        }
        set {
            shared?.set(newValue, forKey: Constants.URLToUse)
            }
    }
    static var connectionOkey: Bool {
        get {
            if let urlOkey = shared?.object(forKey: Constants.ConnectionOkey) as? Bool {
                return urlOkey
            }
            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.ConnectionOkey)
            }
    }
    static var statusIcon: String {
        get {
            if let status = shared?.object(forKey: Constants.StatusIcon) as? String {
                return status
            }
            return "NSStatusNone"
        }
        set {
            shared?.set(newValue, forKey: Constants.StatusIcon)
            }
    }
    static var itemsToShow: [String] {
        get {
            if let item = shared?.object(forKey: Constants.ItemToShow) as? [String] {
                return item
            }
            return []
        }
        set {
            shared?.set(newValue, forKey: Constants.ItemToShow)
            }
    }
    static var iconDicc: [String: String] {
        get {
            if let item = shared?.object(forKey: Constants.IconDicc) as? [String: String] {
                return item
            }
            return [:]
        }
        set {
            shared?.set(newValue, forKey: Constants.IconDicc)
            }
    }
    static var itemTypeDicc: [String: String] {
        get {
            if let item = shared?.object(forKey: Constants.ItemTypeDicc) as? [String: String] {
                return item
            }
            return [:]
        }
        set {
            shared?.set(newValue, forKey: Constants.ItemTypeDicc)
            }
    }
    static var itemNameDicc: [String: String] {
        get {
            if let item = shared?.object(forKey: Constants.ItemNameDicc) as? [String: String] {
                return item
            }
            return [:]
        }
        set {
            shared?.set(newValue, forKey: Constants.ItemNameDicc)
            }
    }
}
