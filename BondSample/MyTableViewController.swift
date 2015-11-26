//
//  MyTableViewController.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/26.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import UIKit
import Bond

class MyTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let captains = ObservableArray(["Archer", "Kirk", "Picard"])
    let firstOfficers = ObservableArray(["T'Pol", "Spock", "Riker"])
    let dataSource = ObservableArray<ObservableArray<String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.extend([captains, firstOfficers])
        dataSource.bindTo(tableView, proxyDataSource: self) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            let name = dataSource[indexPath.section][indexPath.row]
            cell.textLabel!.text = name
            return cell
        }
        
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MyTableViewController: BNDTableViewProxyDataSource {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
}

extension MyTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name = dataSource[indexPath.section][indexPath.row]
        print(name + " selected!")
    }
}
