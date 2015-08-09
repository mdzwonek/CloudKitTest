//
//  MessageCell.swift
//  CloudKitTest
//
//  Created by Mateusz Dzwonek on 30/06/2015.
//  Copyright © 2015 Mateusz Dzwonek. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func prepareForReuse() {
        contentLabel.text = ""
    }
    
}
