//
//  DisplayViewController.swift
//  CloudKitTest
//
//  Created by Mateusz Dzwonek on 30/06/2015.
//  Copyright © 2015 Mateusz Dzwonek. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let CellIdentifier = "Cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var messages = [Message]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshMessages()
    }
    
    @objc private func refreshMessages() {
        DataManager.sharedInstance.getMessagesWithCompletion { (messages, error) -> Void in
            if let error = error {
                NSLog("Error when fetching messages. (Error: \(error))")
            } else {
                self.messages = messages!;
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DisplayViewController.CellIdentifier)
        if let cell = cell as? MessageCell {
            let message = messages[indexPath.row]
            cell.contentLabel.text = message.title
        }
        return cell!
    }
    
}

