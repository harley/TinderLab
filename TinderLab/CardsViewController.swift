//
//  CardsViewController.swift
//  TinderLab
//
//  Created by Harley Trung on 12/16/15.
//  Copyright © 2015 cheetah.com. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    var isPresenting = false

    // get fake bar to compute where to insert profile pic (draggableImageView)
    @IBOutlet weak var fakeNavBarImageView: UIImageView!
    var draggableImageView: DraggableImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        insertProfilePic()
    }

    func onTapDraggable() {
        let profileVC = ProfileViewController()
        profileVC.loadView()
        profileVC.profileImageView.image = draggableImageView.image
        profileVC.transitioningDelegate = self
        profileVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(profileVC, animated: true, completion: nil)
    }

    func insertProfilePic() {
        let margin:CGFloat    = 8
        let dimension:CGFloat = view.frame.width - margin * 2
        let posX = margin
        let posY = margin + fakeNavBarImageView.frame.origin.y + fakeNavBarImageView.frame.height

        draggableImageView = DraggableImageView(frame: CGRect(x: posX, y: posY, width: dimension, height: dimension))
        view.addSubview(draggableImageView)

        // add tap recognizer to transition into ProfileViewController
        let tapProfile = UITapGestureRecognizer(target: self, action: "onTapDraggable")
        draggableImageView.addGestureRecognizer(tapProfile)

        // add a callback to present a new profile after a profile is swiped away
        draggableImageView.callbackAfterRemoving = {
            self.insertNextProfilePic()
        }
    }

    func insertNextProfilePic() {
        let n = arc4random_uniform(60)
        let url = NSURL(string: "https://randomuser.me/api/portraits/med/women/\(n).jpg")!
        print("inserting next pic from", url)

        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let data = data {
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.insertProfilePic()
                    self.draggableImageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}

extension CardsViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        print("isPresenting")
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        print("isDismissing")
        return self
    }
}

extension CardsViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        print("animating")
        let containerView = transitionContext.containerView()!
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC   = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let duration = transitionDuration(transitionContext)
        
        if isPresenting {
            containerView.addSubview(toVC.view)
            toVC.view.alpha = 0
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                toVC.view.alpha = 1
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromVC.view.alpha = 0
            }) { (finished: Bool) -> Void in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}