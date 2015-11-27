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
    let userImageURL : NSURL
    let url : NSURL
    
    init(title : String, username: String, userImageURL : NSURL, url : NSURL){
        self.title = Observable(title)
        self.username = Observable(username)
        self.userImage = Observable<UIImage?>(nil) // initially no image
        self.userImageURL = userImageURL
        self.url = url
    }
    
    func fetchImageIfNeeded(){
        if self.userImage.value != nil {
            // already have photo
            return
        }
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