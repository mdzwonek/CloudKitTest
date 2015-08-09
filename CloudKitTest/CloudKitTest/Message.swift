//
//  Message.swift
//  CloudKitTest
//
//  Created by Mateusz Dzwonek on 30/06/2015.
//  Copyright © 2015 Mateusz Dzwonek. All rights reserved.
//

import CloudKit

class Message {
    
    static let RecordType = "Message"
    static let TitleKey = "title"
    
    private(set) var record: CKRecord
    
    init(withRecord record: CKRecord) {
        self.record = record
    }
    
    init(withTitle title: String) {
        record = CKRecord(recordType: Message.RecordType)
        record[Message.TitleKey] = title
    }
    
    var title: String {
        get {
            return record[Message.TitleKey] as! String
        }
        set {
            record[Message.TitleKey] = newValue
        }
    }
    
}
