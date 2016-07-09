//
//  HomeViewController.swift
//  Shots Implementing
//
//  Created by Ismael Barry on 6/25/15.
//  Copyright (c) 2015 Ismael Barry. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // These four variables must always be included when using UIKit Dynamics.
    var animator: UIDynamicAnimator!
    var attachmentBehavoir: UIAttachmentBehavior! // For panning around freely.
    var gravityBehavoir: UIGravityBehavior! // Making the dialogView fall.
    var snapBehavoir: UISnapBehavior! // Bouncing back to its inital position.
    
    var number = 0
    var data = getData() // Retrieves data from our data.swift file within the Spring folder.

    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundMaskView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoritesLabel: UIImageView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var backgroundMaskViewButton: UIButton!
    @IBOutlet var panGesture: UIPanGestureRecognizer!

    // When the backgroundMaskView gets pressed, then it hides itself like it should initally.
    @IBAction func backgroundMaskViewButtonDidTouch(sender: AnyObject) {
        spring(0.5) {
            self.backgroundMaskViewButton.alpha = 0
        }
        hideShareView()
        hidePopover()
    }
    
    // Each time function is run, it unhides the mask button.
    func showBackgroundMaskViewButton() {
        self.backgroundMaskViewButton.hidden = false
        self.backgroundMaskViewButton.alpha = 0
        spring(0.5){
            self.backgroundMaskViewButton.alpha = 1
        }
    }
    
    @IBAction func userButtonDidTouch(sender: AnyObject) {
        popoverView.hidden = false
        showBackgroundMaskViewButton()
        
        let scaleFirst = CGAffineTransformMakeScale(0.3, 0.3)
        let translateFirst = CGAffineTransformMakeTranslation(50.0, -50.0)
        // The second parameter refers to the starting point, the first parameter refers to the ending point.
        popoverView.transform = CGAffineTransformConcat(scaleFirst, translateFirst)
        popoverView.alpha = 0
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            let scaleSecond = CGAffineTransformMakeScale(1.0, 1.0)
            let translateSecond = CGAffineTransformMakeTranslation(0, 0)
            self.popoverView.transform = CGAffineTransformConcat(scaleSecond, translateSecond)
            self.popoverView.alpha = 1
        }, completion: nil)
    }
    
    func hidePopover() {
        self.popoverView.hidden = true
    }
    
    @IBAction func likeButtonDidTouch(sender: AnyObject) {
    }
    
    @IBAction func shareButtonDidTouch(sender: AnyObject) {
        // In storyboard -> attributes inspector -> the shareView is hidden. Hoewever, when we click the share button, the share view pops up.
        shareView.hidden = false
        showBackgroundMaskViewButton()
        shareView.transform = CGAffineTransformMakeTranslation(0, 200)
        emailButton.transform = CGAffineTransformMakeTranslation(0, 200)
        emailLabel.transform = CGAffineTransformMakeTranslation(0, 200)
        twitterButton.transform = CGAffineTransformMakeTranslation(0, 200)
        twitterLabel.transform = CGAffineTransformMakeTranslation(0, 200)
        facebookButton.transform = CGAffineTransformMakeTranslation(0, 200)
        facebookButton.transform = CGAffineTransformMakeTranslation(0, 200)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.emailLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.10, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.twitterLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.15, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.facebookLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
            self.shareLabel.alpha = 1
        }, completion: nil)
    }
    
    func hideShareView() {
        spring(0.5) {
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
            self.shareView.hidden = true
        }
    }
    
    @IBAction func imageButtonDidTouch(sender: AnyObject) {
        springComplete(0.7, animations: {
            self.dialogView.frame = CGRectMake(0, 0, 320, 568)
            self.dialogView.layer.cornerRadius = 0
            self.imageButton.frame = CGRectMake(0, 0, 320, 240)
            self.likeButton.alpha = 0
            self.shareButton.alpha = 0
            self.userButton.alpha = 0
            self.headerView.alpha = 0
            }, completion: { finished in
                self.performSegueWithIdentifier("homeToDetail", sender: self)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "homeToDetail" {
            let toView = segue.destinationViewController as! DetailViewController
            toView.data = data
            toView.number = number
        }
    }
    
    @IBAction func panGestureMoving(sender: AnyObject) {
        let location = sender.locationInView(view) // view is equivalent to canvas view.
        let boxlocation = sender.locationInView(dialogView) // Location of dialogView
        
        if sender.state == UIGestureRecognizerState.Began {
            // When we add behavoirs, we must also remove older behavoirs.
            //animator.removeBehavior(snapBehavoir)
            // Everytime we pan the dialogView, we track its coordinates.
            let centerOffset = UIOffsetMake(boxlocation.x - CGRectGetMidX(dialogView.bounds), boxlocation.y - CGRectGetMidY(dialogView.bounds))
            attachmentBehavoir = UIAttachmentBehavior(item: dialogView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavoir.frequency = 0
            // An attachmentBehavoir must always be added to an animator.
            animator.addBehavior(attachmentBehavoir)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavoir.anchorPoint = location
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            // Removes any type of behavior that previously was.
            animator.removeBehavior(attachmentBehavoir)
            snapBehavoir = UISnapBehavior(item: dialogView, snapToPoint: view.center)
            animator.addBehavior(snapBehavoir)
            
            let translation = sender.translationInView(view)
            if translation.y > 100 {
                animator.removeAllBehaviors()
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVectorMake(0, 10)
                animator.addBehavior(gravity)
                
                // Causes a slight delay so we see the animation of the new dialogView once the old dialogView falls.
                delay(0.3) {
                    self.refreshView()
                }
            }
        }
    }
    
    func refreshView() {
        number += 1
        if number > 3 {
            number = 0
        }
        animator.removeAllBehaviors()
        snapBehavoir = UISnapBehavior(item: dialogView, snapToPoint: view.center)
        attachmentBehavoir.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // In UIKit Dynamics, the animator must always be initialized.
        animator = UIDynamicAnimator(referenceView: view) // referenceView is entire iphone canvas.
        
        insertBlurView(backgroundMaskView, style: UIBlurEffectStyle.Dark)
        insertBlurView(headerView, style: UIBlurEffectStyle.Dark)
        
        dialogView.alpha = 0
     }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        dialogView.alpha = 1
        
        let scaleFirst = CGAffineTransformMakeScale(0.5, 0.5)
        let translateFirst = CGAffineTransformMakeTranslation(0.0, -200.0)
        // The second parameter refers to the starting point, the first parameter refers to the ending point.
        dialogView.transform = CGAffineTransformConcat(scaleFirst, translateFirst)
        
        spring(0.5){
            let scaleSecond = CGAffineTransformMakeScale(1.0, 1.0)
            let translateSecond = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scaleSecond, translateSecond)
        }
        
        avatarImageView.image = UIImage(named: data[number]["avatar"]!)
        imageButton.setImage(UIImage(named: data[number]["image"]!), forState: UIControlState.Normal)
        backgroundImageView.image = UIImage(named: data[number]["image"]!)
        authorLabel.text = data[number]["author"]
        titleLabel.text = data[number]["title"]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
