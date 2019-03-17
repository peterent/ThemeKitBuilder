//
//  UKit+Extensions.swift
//  ThemeKit
//
//  Created by Peter Ent on 3/16/19.
//  Copyright © 2019 Keaura. All rights reserved.
//

import UIKit

/*
 * This extension of UIView enables additional properties that can be
 * configured as part of the UIAppearance protocol. In other words, you
 * can now do UIView.appearance().borderColor = UIColor.red
 */
extension UIView {
    @objc dynamic var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @objc dynamic var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            if let cgColor = layer.shadowColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
}

