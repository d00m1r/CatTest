//
//  Describable.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import UIKit

protocol Describable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension Describable {

    var typeName: String {
        return String(describing: self)
    }

    static var typeName: String {
        return String(describing: self)
    }
}

extension Describable where Self: NSObjectProtocol {

    var typeName: String {
        return String(describing: type(of: self))
    }
}

extension UITableViewCell: Describable {}

