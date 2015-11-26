//
//  ObserveNotificationViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/26.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class ObserveNotificationViewController: UIViewController {
    
    let myNotificationName = "MyNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().bnd_notification(myNotificationName, object: nil)
            .observe { notification in
                print("Got \(notification)")
                
                let alert = UIAlertController(title: "Got Notification!", message: nil, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            .disposeIn(bnd_bag)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postNotification(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName(myNotificationName, object: nil)
    }
}
