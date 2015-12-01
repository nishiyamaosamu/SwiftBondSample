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
            .map {
                let date_formatter = NSDateFormatter()
                date_formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                return date_formatter.stringFromDate($0)
            }
            .bindTo(label.bnd_text)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}