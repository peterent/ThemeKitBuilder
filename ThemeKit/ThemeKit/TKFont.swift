//
//  TKFont.swift
//  ThemeKit
//
//  Created by Peter Ent on 3/14/19.
//  Copyright © 2019 Keaura. All rights reserved.
//

import UIKit

public struct TKFont {
    var fontName = "system"
    var style = "regular"
    
    init(_ dict: [String: Any]) {
        if let name = dict["font"] as? String, let styleType = dict["style"] as? String {
            fontName = name
            style = styleType
        }
    }
    
    func font(ofSize size: CGFloat) -> UIFont? {
        if fontName == "system" {
            switch style {
            case "bold":
                return UIFont.boldSystemFont(ofSize: size)
            case "italic":
                return UIFont.italicSystemFont(ofSize: size)
            default:
                return UIFont.systemFont(ofSize: size)
            }
        } else {
            return nil
        }
    }
}
