//
//  ViewController.swift
//  ThemeKitBuilder
//
//  Created by Peter Ent on 3/9/19.
//  Copyright © 2019 Keaura. All rights reserved.
//

import UIKit
import ThemeKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var someView: UIView!
    @IBOutlet private weak var someButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        someView.backgroundColor = UIColor(named: "blueBackground")//ThemeKit.shared.color(name: "black25%")
    }


}

