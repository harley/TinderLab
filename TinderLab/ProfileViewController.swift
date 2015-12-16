//
//  ProfileViewController.swift
//  TinderLab
//
//  Created by Harley Trung on 12/16/15.
//  Copyright © 2015 cheetah.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBAction func onNavbarTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
}
