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
    static let EditSegueIdentifier = "EditSegue"
    
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl = UIRefreshControl()
    
    private var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: "refreshMessages", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshMessages()
    }
    
    @objc private func refreshMessages() {
        DataManager.sharedInstance.getMessagesWithCompletion { (messages, error) -> Void in
            if let messages = messages {
                self.messages = messages;
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DisplayViewController.EditSegueIdentifier {
            let cell = sender as! MessageCell
            let index = tableView.indexPathForCell(cell)!
            let message = messages[index.row]
            let composeViewController = segue.destinationViewController as! ComposeViewController
            composeViewController.message = message
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

