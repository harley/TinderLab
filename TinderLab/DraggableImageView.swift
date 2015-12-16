//
//  DraggableImageView.swift
//  TinderLab
//
//  Created by Harley Trung on 12/16/15.
//  Copyright © 2015 cheetah.com. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {
    var originalCenter: CGPoint!
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(superview)
        if sender.state == .Began {
            originalCenter = imageView.center
        } else if sender.state == .Changed {
            imageView.center.x = location.x
        } else if sender.state == .Ended {
            imageView.center = originalCenter
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    @IBOutlet var contentView: UIView!
    
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        // custom initialization logic
    }
}
