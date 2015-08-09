//
//  ComposeViewController.swift
//  CloudKitTest
//
//  Created by Mateusz Dzwonek on 30/06/2015.
//  Copyright © 2015 Mateusz Dzwonek. All rights reserved.
//

import UIKit
import CloudKit

class ComposeViewController: UIViewController {
    
    var message: Message?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let message = message {
            textView.text = message.title
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismiss()
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let completion: NSError? -> Void = { error -> Void in
            if let error = error {
                NSLog("Error when saving message: \(error)")
            }
            self.dismiss()
        }
        
        if let message = message {
            DataManager.sharedInstance.updateMessage(message, withTitle: textView.text, andCompletion: completion)
        } else {
            let message = Message(withTitle: textView.text)
            DataManager.sharedInstance.addMessage(message, withCompletion: completion)
        }
    }
    
    func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
    }
    
}

