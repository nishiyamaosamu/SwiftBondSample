//
//  Feed.swift
//  BondSample
//
//  Created by Osamu Nishiyama on 2015/11/27.
//  Copyright © 2015年 ever sense. All rights reserved.
//

import Foundation
import Bond

class Feed {
    
    let title : Observable<String?>
    let username : Observable<String?>
    let userImage : Observable<UIImage?>
    let userImageURL : NSURL?
    let url : NSURL?
    
    init(title : String?, username: String?, userImageURL : String?, url : String?){
        self.title = Observable(title)
        self.username = Observable(username)
        self.userImage = Observable<UIImage?>(nil) // initially no image
        if userImageURL != nil {
            self.userImageURL = NSURL(string: userImageURL!)
        }else{
            self.userImageURL = nil
        }
        if url != nil {
            self.url = NSURL(string: url!)
        }else{
            self.url = nil
        }
        
    }
    
    func fetchImageIfNeeded(){
        if self.userImage.value != nil {
            // already have photo
            return
        }
        if let userImageURL = self.userImageURL {
            let downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(userImageURL) {
                [weak self] location, response, error in
                if let location = location {
                    if let data = NSData(contentsOfURL: location) {
                        if let image = UIImage(data: data) {
                            dispatch_async(dispatch_get_main_queue()) {
                                // this will automatically update photo in bonded image view
                                self?.userImage.value = image
                                return
                            }
                        }
                    }
                }
            }
            downloadTask.resume()
        }
    }
}