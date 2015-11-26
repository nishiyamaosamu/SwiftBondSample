//
//  BidirectionalBindingViewController.swift
//  BondSample
//
//  Created by nishiyamaosamu on 2015/11/26.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class BidirectionalBindingViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textFeild2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.bnd_text
            .bidirectionalBindTo(textFeild2.bnd_text)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}