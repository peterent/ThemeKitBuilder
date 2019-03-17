//
//  TKBorder.swift
//  ThemeKit
//
//  Created by Peter Ent on 3/14/19.
//  Copyright © 2019 Keaura. All rights reserved.
//

import UIKit

public struct TKBorder {
    var width: CGFloat = 0
    var color: UIColor?
    var cornerRadius: CGFloat = 0
    
    init(_ dict: [String: Any], kit: ThemeKit) {
        guard let width = dict["width"] as? Double,
            let colorName = dict["color"] as? String,
            let cornerRadius = dict["cornerRadius"] as? Double else {
                return
        }
        self.width = CGFloat(width)
        self.color = kit.colors[colorName]
        self.cornerRadius = CGFloat(cornerRadius)
    }
}
