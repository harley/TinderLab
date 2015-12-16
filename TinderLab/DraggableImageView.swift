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
    var callbackAfterRemoving: (() -> Void)?
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(superview)
        let translation = sender.translationInView(superview)
        
        if sender.state == .Began {
            originalCenter = center

        } else if sender.state == .Changed {
            center.x = originalCenter.x + translation.x
            
            let angle:CGFloat = translation.x * 30.0 / frame.width
            let coeff:CGFloat = location.y > (frame.origin.y + frame.width / 2) ? -1 : 1
            let angleInRadians = coeff * angle * CGFloat(M_PI) / 180.0
            transform = CGAffineTransformMakeRotation(angleInRadians)
            
        } else if sender.state == .Ended {
            print("translation ", translation.x)
            if translation.x > 50 {
                // animate the photo off the screen to the right
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.center.x += self.frame.width
                    }, completion: { (finished) -> Void in
                        self.removeFromSuperview()
                        self.callbackAfterRemoving?()
                })
            } else if translation.x < -50 {
                // animate the photo off the screen to the left
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.center.x -= self.frame.width
                    }, completion: { (finished) -> Void in
                        self.removeFromSuperview()
                        self.callbackAfterRemoving?()
                        
                })
            } else {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.center = self.originalCenter
                    self.transform = CGAffineTransformMakeRotation(0)
                })
            }
        }
    }

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak internal var imageView: UIImageView!
    // Make DraggableImageView behave like a UIImageView instance
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
