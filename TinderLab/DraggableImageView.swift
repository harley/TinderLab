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
        guard !self.imageView.hidden else { return }
        
        let location = sender.locationInView(superview)
        let translation = sender.translationInView(superview)
        
        if sender.state == .Began {
            originalCenter = imageView.center
        } else if sender.state == .Changed {
            center.x = location.x
            
            let angle:CGFloat = translation.x * 30.0 / 304
            let coeff:CGFloat = location.y > (64 + 152) ? -1 : 1
            let angleInRadians = coeff * angle * CGFloat(M_PI) / 180.0
            transform = CGAffineTransformMakeRotation(angleInRadians)
            
        } else if sender.state == .Ended {
            if translation.x > 50 {
                // animate the photo off the screen to the right
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.center.x += self.frame.width
                    }, completion: { (finished) -> Void in
                        self.hidden = true
                })
            } else if translation.x < -50 {
                // animate the photo off the screen to the left
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.imageView.center.x -= self.frame.width
                    }, completion: { (finished) -> Void in
                        self.imageView.hidden = true
                        
                })
            } else {
                imageView.center = originalCenter
                imageView.transform = CGAffineTransformIdentity
            }
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
