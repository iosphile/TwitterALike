//
//  Tweet.swift
//  TwitterAlike
//
//  Created by Rajesh Kommana on 20/6/17.
//  Copyright © 2017 Rajesh Kommana. All rights reserved.
//

import Foundation

class Tweet {
    
    var tweetData: String?
    var date: String?
    
    init(tweetData: String, date:String) {
        self.tweetData = tweetData
        self.date = date
    }
    
}
