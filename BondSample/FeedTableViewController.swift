//
//  FeedTableViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/27.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class FeedTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let feedViewModel = FeedTableViewModel()
    var timeCounter = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        feedViewModel.request()
        let dataSource = ObservableArray([feedViewModel.items])

        dataSource.bindTo(tableView) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath)
            let feed = dataSource[indexPath.section][indexPath.row] as Feed
            cell.textLabel!.text = feed.title
            cell.detailTextLabel?.text = feed.username
            return cell
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onUpdate(timer : NSTimer){
        self.timeCounter--
        print(self.timeCounter)
        
        self.navigationItem.title = "Update in \(self.timeCounter) sec"
        if self.timeCounter <= 0 {
            self.feedViewModel.request()
            self.navigationItem.title = "Requested!!"
            timer.invalidate()
        }
    }
    
}
//
//extension MyTableViewController: BNDTableViewProxyDataSource {
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Header"
//    }
//}
//
//extension MyTableViewController: UITableViewDelegate {
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let name = dataSource[indexPath.section][indexPath.row]
//        print(name + " selected!")
//    }
//}
