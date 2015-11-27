//
//  FeedTableViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/27.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond
import SafariServices

class FeedTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let feedViewModel = FeedTableViewModel()
    var dataSource = ObservableArray<ObservableArray<Feed>>()
    var timeCounter = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ObservableArray([feedViewModel.items])
        
        dataSource.bindTo(tableView) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedTableCell
            let feed = dataSource[indexPath.section][indexPath.row]
            feed.title.bindTo(cell.title.bnd_text).disposeIn(cell.bnd_bag)
            feed.username.bindTo(cell.username.bnd_text).disposeIn(cell.bnd_bag)
            feed.userImage.bindTo(cell.userImageView.bnd_image).disposeIn(cell.bnd_bag)
            feed.fetchImageIfNeeded()
            return cell
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onUpdate:"), userInfo: nil, repeats: true)
        
        tableView.delegate = self
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

extension FeedTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let feed = dataSource[indexPath.section][indexPath.row]
        let safariVC = SFSafariViewController(URL: feed.url)
        self.navigationController?.showViewController(safariVC, sender: nil)
    }
}
