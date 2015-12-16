//
//  CardsViewController.swift
//  TinderLab
//
//  Created by Harley Trung on 12/16/15.
//  Copyright © 2015 cheetah.com. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let draggableImageView = DraggableImageView(frame: CGRect(x: 8, y: 72, width: 304, height: 304))
        view.addSubview(draggableImageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
