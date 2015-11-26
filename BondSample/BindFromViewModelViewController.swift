//
//  BindFromViewModelViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/26.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class BindFromViewModelViewController : UIViewController {
    
    @IBOutlet weak var label: UILabel!
    let timeViewModel = TimeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timeViewModel.timestamp
            .map { "\($0)" }
            .bindTo(label.bnd_text)
        
        NSNotificationCenter.defaultCenter().bnd_notification("aaa", object: nil)
            .observe { notification in
                print("Got \(notification)")
            }
            .disposeIn(bnd_bag)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}