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
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismiss()
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let message = Message(withTitle: textView.text)
        DataManager.sharedInstance.addMessage(message) { error -> Void in
            if let error = error {
                NSLog("Error when saving message: \(error)")
            }
            self.dismiss()
        }
    }
    
    func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
    }
    
}

