//
//  TweetsTableViewController.swift
//  TwitterAlike
//
//  Created by Rajesh Kommana on 19/6/17.
//  Copyright © 2017 Rajesh Kommana. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TweetsTableViewController: UITableViewController {
    var userInfo: NSDictionary?
    var tweets:[Tweet] = [Tweet]()
    
    let ref = Database.database().reference()
    var tweetsRef: DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(userInfo!["name"]!)"
        tweetsRef = ref.child("tweets")
        
       

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        queryFIRBase { (array) in
            //print(array)
            self.tweets = array as! [Tweet]
            self.tableView.reloadData()
        }
    }
    

   /* @IBAction func postNewTweet(_ sender: Any) {
        performSegue(withIdentifier: "goToPostTweet", sender: self)
    } */
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        cell.backgroundColor =  UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: CGFloat(indexPath.row) / 10)
        let tweet = tweets[indexPath.row]
        cell.textLabel?.text = tweet.date
        cell.detailTextLabel?.text = tweet.tweetData
        
        

        return cell
    }
   

    // Firebase Query to get tweets
    
    
    func queryFIRBase(_ completion: @escaping (_ tweetsArray: NSArray) -> ()) {
        
        var array: [Tweet] = [Tweet]()
    
        
            tweetsRef?.observe(.value, with: { (snapshot) in
                
                let item = snapshot as DataSnapshot
                
                if let dict = item.value as? NSDictionary {
                    
                    if let tweetsDict = dict as? NSDictionary {
                        
                        for tweet in tweetsDict {
                            
                            let tweetItem = tweet.value as! NSDictionary
                            
                            let tweetTxt = tweetItem["tweet"] as! String
                            let tweetDate = tweetItem["date"] as! String
                            
                           let newItem = Tweet(tweetData: tweetTxt, date: tweetDate)
                            array.append(newItem)
                            
                           
                            
                        } // for
                    } // if
                } //if
                
                completion(array as NSArray)
            })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPostTweet" {
            
            let destinationVC = segue.destination as! TweetVC
            destinationVC.userInfo = self.userInfo
            
            
        }
    }
    
    
    


}
