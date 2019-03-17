//
//  ThemeKit.swift
//  ThemeKitBuilder
//
//  Created by Peter Ent on 3/9/19.
//  Copyright © 2019 Keaura. All rights reserved.
//

import UIKit

public class ThemeKit {
    
    // MARK: - PUBLIC
    
    public static var shared = ThemeKit()
    
    public init() {
        
    }
    
    public func load(themeResource: String) {
        loadPropertyList(themeResource)
    }
    
    public func apply() {
        applyAppearances()
    }
    
    public func color(name colorName: String) -> UIColor? {
        return colors[colorName]
    }
    
    public func border(for typeName: String) -> TKBorder? {
        guard let borderName = content(for: typeName, of: "border") as? String else {
            return nil
        }
        return borders[borderName]
    }
    
    public func content(for typeName: String, of propertyName: String) -> Any? {
        guard let template = application[typeName] else {
            return nil
        }
        return template.content?[propertyName]
    }
    
    // MARK: - TEMPLATE
    
    /*
     * Template is used to hold class appearance name:value pairs until they can be applied
     * to the classes using the apply() functions.
     */
    fileprivate class Template {
        var content: [String: Any]?
        
        func apply(to classType: UIControl.Type, kit: ThemeKit) {
            if let colorName = content?["backgroundColor"] as? String, let color = kit.colors[colorName] {
                classType.appearance().backgroundColor = color
            }
            if let colorName = content?["tintColor"] as? String, let color = kit.colors[colorName] {
                classType.appearance().tintColor = color
            }
            if let borderName = content?["border"] as? String, let border = kit.borders[borderName] {
                classType.appearance().borderWidth = border.width
                classType.appearance().borderColor = border.color
                classType.appearance().cornerRadius = border.cornerRadius
            }
        }
        
        func apply(to classType: UILabel.Type, kit: ThemeKit) {
            if let colorName = content?["textColor"] as? String, let color = kit.colors[colorName] {
                classType.appearance().textColor = color
            }
            if let value = content?["font"] as? String, let size = content?["fontSize"] as? Double, let tkFont = kit.fonts[value] {
                classType.appearance().font = tkFont.font(ofSize: CGFloat(size))
            }
        }
        
        func apply(to classType: UISwitch.Type, kit: ThemeKit) {
            if let colorName = content?["onTintColor"] as? String, let color = kit.colors[colorName] {
                classType.appearance().onTintColor = color
            }
        }
        
        func apply(to classType: UIView.Type, kit: ThemeKit) {
            if let colorName = content?["backgroundColor"] as? String, let color = kit.colors[colorName] {
                classType.appearance().backgroundColor = color
            }
            if let borderName = content?["border"] as? String, let border = kit.borders[borderName] {
                classType.appearance().borderWidth = border.width
                classType.appearance().borderColor = border.color
                classType.appearance().cornerRadius = border.cornerRadius
            }
        }
    }
    
    // MARK: - PRIVATE
    
    public var colors = [String: UIColor]()
    public var borders = [String: TKBorder]()
    public var fonts = [String: TKFont]()
    fileprivate var application = [String: Template]()
    
    private func loadPropertyList(_ resourceName: String) {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: "plist"),
            let contents = try? Data(contentsOf: url),
            let myPlist = try? PropertyListSerialization.propertyList(from: contents, options: [], format: nil) as? [String:Any] {
            decodeColors(myPlist?["colors"] as? [String: String])
            decodeBorders(myPlist?["borders"] as? [String: Any])
            decodeFonts(myPlist?["fonts"] as? [String: Any])
            decodeAppearances(myPlist?["application"] as? [String: Any])
        }
    }
    
    private func decodeColors(_ dict: [String: String]?) {
        guard let dict = dict else { return }
        colors.removeAll()
        for (colorName,colorValue) in dict {
            let parts = colorValue.components(separatedBy: ",")
            if let red = Double(parts[0]), let green = Double(parts[1]), let blue = Double(parts[2]), let alpha = Double(parts[3]) {
                colors[colorName] = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/100.0)
            }
        }
    }
    
    private func decodeBorders(_ dict: [String: Any]?) {
        guard let dict = dict else { return }
        borders.removeAll()
        for (borderName, value) in dict {
            if let borderDict = value as? [String: Any] {
                borders[borderName] = TKBorder(borderDict, kit: self)
            }
        }
    }
    
    private func decodeFonts(_ dict: [String: Any]?) {
        guard let dict = dict else { return }
        fonts.removeAll()
        for (fontName, value) in dict {
            if let fontDict = value as? [String: Any] {
                fonts[fontName] = TKFont(fontDict)
            }
        }
    }
    
    private func decodeAppearances(_ dict: [String: Any]?) {
        guard let dict = dict else { return }
        application.removeAll()
        
        for (typeName, value) in dict {
            if let content = value as? [String: Any] {
                let template = Template()
                template.content = content
                application[typeName] = template
            }
        }
    }
    
    private func applyAppearances() {
        var moduleName = ""
        if let ns = String(describing: self).components(separatedBy: ".").first {
            moduleName = ns + "."
        }
        for (typeName, template) in application {
            let qualifiedClassName = moduleName + typeName
            
            // qualified (namespace + class) 
            if let classType = NSClassFromString(qualifiedClassName) as? UIControl.Type {
                template.apply(to: classType, kit: self)
                if let classType = NSClassFromString(qualifiedClassName) as? UISwitch.Type {
                    template.apply(to: classType, kit: self)
                }
            } else if let classType = NSClassFromString(qualifiedClassName) as? UILabel.Type {
                template.apply(to: classType, kit: self)
            } else if let classType = NSClassFromString(qualifiedClassName) as? UIView.Type {
                template.apply(to: classType, kit: self)
            }
                
            // unqualified (UIKit) generics
            else if let classType = NSClassFromString(typeName) as? UIControl.Type {
                template.apply(to: classType, kit: self)
                if let classType = NSClassFromString(typeName) as? UISwitch.Type {
                    template.apply(to: classType, kit: self)
                }
            }
        }
    }
}
