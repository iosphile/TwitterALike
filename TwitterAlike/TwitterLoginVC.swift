//
//  TwitterLoginVC.swift
//  TwitterAlike
//
//  Created by Rajesh Kommana on 19/6/17.
//  Copyright © 2017 Rajesh Kommana. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore
import FirebaseAuth
import FirebaseCore

class TwitterLoginVC: UIViewController {
    var loginButton: TWTRLogInButton?
    var userInfo: NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        twiiterLogin()

 
    }
    
    func twiiterLogin() {
        loginButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                //print("signed in as \(session!.userName!)");
               self.connetWithTwitter(session: session!)
            } else {
                //print("error: \(error.localizedDescription)");
            }
        })
        loginButton!.center = self.view.center
        self.view.addSubview(loginButton!)
    }
    
    func connetWithTwitter(session: TWTRSession) {
        let credential = TwitterAuthProvider.credential(withToken: session.authToken, secret: session.authTokenSecret)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error == nil {
                print("\(user!.displayName!) logged in successfully!!!")
                self.getCurrentUserInfo(user: user!)
                
                
            } else {
                print(error!.localizedDescription)
            }
      
        }
    
    

    
    }
    
    func getCurrentUserInfo(user: User) {
        
        let name = user.displayName
        let avatar = user.photoURL
        self.userInfo = ["name": name!, "avatar": "\(avatar!)"]
        print(userInfo!)
        self.performSegue(withIdentifier: "goToTweets", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTweets" {
            
            let destinationVC = segue.destination as! TweetsTableViewController
            destinationVC.userInfo = self.userInfo
            
            
            
        }
    }
    
    
}
