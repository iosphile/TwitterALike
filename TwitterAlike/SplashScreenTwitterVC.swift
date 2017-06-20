//
//  SplashScreenTwitterVC.swift
//  TwitterAlike
//
//  Created by Rajesh Kommana on 18/6/17.
//  Copyright © 2017 Rajesh Kommana. All rights reserved.
//

import UIKit

class SplashScreenTwitterVC: UIViewController {
    
    var logoImage: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1)
        logoImage = UIImageView()
        logoImage?.frame = CGRect(x: (self.view.bounds.width / 2) - 50, y: (self.view.bounds.height / 2) - 50, width: 100, height: 100)
        logoImage?.image = UIImage(named: "logo.png")
        logoImage?.contentMode = .scaleAspectFit
        self.view.addSubview(logoImage!)
        animateLogo()
    }
    
    func animateLogo() {
        
        let duration = 1.0
        let delay = 1.5
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations:
                {
                    self.logoImage!.bounds = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2, width: 90, height: 90)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.33, animations:
                {
                    self.logoImage!.bounds = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2, width: 1500, height: 1500)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.33, animations:
                {
                    self.logoImage!.bounds = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2, width: 3000, height: 3000)
            })
            
            
            
            
            
        }, completion: {(finished) in
            
            self.goToLoginVC()
        
        
        })
    
    
    }
    
    func goToLoginVC() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goToLoginView", sender: self)
        }
        
    }
    
    
    
}
