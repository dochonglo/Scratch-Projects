//
//  DetailViewController.swift
//  Shots Implementing
//
//  Created by Ismael Barry on 6/26/15.
//  Copyright (c) 2015 Ismael Barry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    var data = getData()
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backButton.alpha = 0
        
        authorLabel.text = data[number]["author"]
        textView.text = data[number]["text"]
        avatarImageView.image = UIImage(named: data[number]["avatar"]!)
        imageView.image = UIImage(named: data[number]["image"]!)
        
        textViewWithFont(textView, fontName: "Libertad", fontSize: 16, lineSpacing: 7)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        backButton.alpha = 1
        springScaleFrom(backButton!, x: -100, y: 0, scaleX: 0.5, scaleY: 0.5)
        
    }
    
    @IBAction func backButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("detailToHome", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailToHome" {
            let toView = segue.destinationViewController as! HomeViewController
            toView.data = data
            toView.number = number
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
