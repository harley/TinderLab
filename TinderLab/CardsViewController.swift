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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let draggableImageView = DraggableImageView(frame: CGRect(x: 8, y: 80, width: 304, height: 304))
        view.addSubview(draggableImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: "onTapDraggable")
        draggableImageView.addGestureRecognizer(tap)
    }
    
    func onTapDraggable() {
        let profileVC = ProfileViewController()
        profileVC.transitioningDelegate = self
        profileVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(profileVC, animated: true) { () -> Void in
            print("presentViewController")
        }
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
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // TODO: animate the transition in Step 3 below
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