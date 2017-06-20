//
//  TweetVC.swift
//  TwitterAlike
//
//  Created by Rajesh Kommana on 19/6/17.
//  Copyright © 2017 Rajesh Kommana. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TweetVC: UIViewController {
    
    var userInfo: NSDictionary?

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var avatarItem: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    var numberOfCharactersLeft: UIBarButtonItem = UIBarButtonItem()
    var tweetBarButtonItem: UIBarButtonItem?
    var tweetBtn: UIButton?
    
    // Databse reference
    let ref = Database.database().reference()
    var tweetsRef: DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        addToolbar(textView: tweetTextView)
        
        // tweets reference
        tweetsRef = ref.child("tweets")

    }

    @IBAction func tweetCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func addToolbar(textView: UITextView) {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 29/255.0, green: 160/255.0, blue: 242/255.0, alpha: 1)
        
        
        tweetBarButtonItem = UIBarButtonItem(customView: addTweetBtn())
        
        let avatarBarButtonItem = UIBarButtonItem(customView: downloadAvatarAndAddImage())
        navBar.topItem?.leftBarButtonItems?[0] = avatarBarButtonItem
        
        
        numberOfCharactersLeft = UIBarButtonItem(title: "140", style: .plain, target: nil, action: nil)
        numberOfCharactersLeft.tintColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1)
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TweetVC.doneBtnAction))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(TweetVC.cancelBtnAction))
        toolBar.setItems([cancelBtn,spaceBtn,numberOfCharactersLeft, tweetBarButtonItem!, doneBtn], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar
        
        
        
    }
    
    func doneBtnAction() {
        
    }
    func cancelBtnAction() {
        
    }
    func sendTweetAction() {
        print("Tweet sending....")
        let tweet = tweetTextView!.text!
        let date = displayDate()
        let tweetRef: DatabaseReference = tweetsRef!.child(date)
        let tweetDict: NSDictionary = ["tweet": tweet, "date": date]
        tweetRef.setValue(tweetDict)
        print("\(tweet) sent successfully")
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    func displayDate() -> String {
        
        let currentDate = Date()
        let formateDate = DateFormatter()
        formateDate.dateStyle = .long
        formateDate.timeStyle = .short
        
        
        return formateDate.string(from: currentDate)
    }
    func enableTweetBtn(btn: UIButton, enabled: Bool) {
        
        if enabled {
            
            btn.backgroundColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1)
            btn.isEnabled = true
            btn.tintColor = UIColor.white
        } else {
            btn.backgroundColor = UIColor.clear
            btn.isEnabled = false
            btn.tintColor = UIColor.darkGray
        }
    }
    
    
    func downloadAvatarAndAddImage() -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let avatar = userInfo!["avatar"] as! String
        downloadImageUrl(imageUrl: avatar) { (avatarImage) in
            imageView.image = avatarImage
            
        }
        
        
        
        
        return imageView
    }
    
    func downloadImageUrl(imageUrl: String, completion: @escaping (_ image: UIImage) -> ()) {
        
        let imageURL = URL(string: imageUrl)!
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            
            if error == nil {
                
                if  let imageData =  data {
                
                do {
                    DispatchQueue.main.async(execute: {
                        let image = UIImage(data: imageData)
                        completion(image!)
                    })
                   
                    
                } //do
                catch {
                    print(error.localizedDescription)
                    } // catch
            } // if
            
            }
            
            
            
            
        } // data task
        
        
        task.resume()
        
    }
    
    
    
    func addTweetBtn() -> UIView {
        tweetBtn = UIButton(type: UIButtonType.custom)
        tweetBtn!.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        tweetBtn!.setTitle("Tweet", for: .normal)
        tweetBtn!.setTitleColor(UIColor.gray, for: .highlighted)
        tweetBtn!.titleLabel?.font = UIFont(name: "Arial", size: 14)
        tweetBtn!.addTarget(self, action: #selector(TweetVC.sendTweetAction), for: .touchUpInside)
        tweetBtn!.layer.cornerRadius = 3
        tweetBtn!.clipsToBounds = true
        enableTweetBtn(btn: tweetBtn!, enabled: false)
        return tweetBtn!
    }
    

  

}

extension TweetVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let tweetText = textView.text! as NSString
        //print("140 - \(tweetText.length)")
        numberOfCharactersLeft.title = "\(140 - tweetText.length)"
        if tweetText.length > 140 {
            
           numberOfCharactersLeft.tintColor = UIColor.red
            enableTweetBtn(btn: tweetBtn!, enabled: false)
        } else {
            numberOfCharactersLeft.tintColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1)
        }
        if tweetText == "" || tweetText.length > 140 {
            
            enableTweetBtn(btn: tweetBtn!, enabled: false)
        } else {
            enableTweetBtn(btn: tweetBtn!, enabled: true)
        }
    }
    
    
    
}




