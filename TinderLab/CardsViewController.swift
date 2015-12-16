//
//  CardsViewController.swift
//  TinderLab
//
//  Created by Harley Trung on 12/16/15.
//  Copyright © 2015 cheetah.com. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        if sender.state == .Began {
            originalCenter = profileImageView.center
        } else if sender.state == .Changed {
            profileImageView.center.x = location.x
        } else if sender.state == .Ended {
            profileImageView.center = originalCenter
        }
    }
    
    var originalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        originalCenter = profileImageView.frame.origin
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
