//
//  BasicBindViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/26.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class BasicBindViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.bnd_text
            .observe { text in
                print(text)
        }
        
        textField.bnd_text
            .bindTo(label.bnd_text)

        //Skip at first time
        textField.bnd_text
            .observeNew { text in
                print(text)
        }
        
        //Skip at first time
        textField.bnd_text
            .skip(1)
            .bindTo(label2.bnd_text)


        textField.bnd_text
            .map { "Hi " + $0! }
            .bindTo(label3.bnd_text)
        
        button.bnd_controlEvent
            .filter { $0 == UIControlEvents.TouchUpInside }
            .observe { e in
                print("Button tapped.(bnd_controlEvent with filter)")
        }
        
        button.bnd_tap
            .observe {
                print("Button tapped.(bnd_tap)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}