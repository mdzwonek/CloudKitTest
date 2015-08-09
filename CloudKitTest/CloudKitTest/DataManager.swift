//
//  DataManager.swift
//  CloudKitTest
//
//  Created by Mateusz Dzwonek on 30/06/2015.
//  Copyright © 2015 Mateusz Dzwonek. All rights reserved.
//

import Foundation
import CloudKit

class DataManager {
    
    static let sharedInstance = DataManager()
    
    var database: CKDatabase {
        get {
            return CKContainer.defaultContainer().publicCloudDatabase
        }
    }
    
    func getMessagesWithCompletion(completion: ([Message]?, NSError?) -> Void) {
        let query = CKQuery(recordType: Message.RecordType, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        database.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            var messages: [Message]? = nil
            if let records = records {
                messages = records.map({ Message(withRecord: $0) })
            }
            dispatch_async(dispatch_get_main_queue(), {
                completion(messages, error)
            })
        }
    }
    
    func addMessage(message: Message, withCompletion completion: NSError? -> Void) {
        database.saveRecord(message.record) { (record, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                completion(error)
            })
        }
    }
    
    func updateMessage(message: Message, withTitle title: String, andCompletion completion: NSError? -> Void) -> Void {
        message.title = title
        let operation = CKModifyRecordsOperation(recordsToSave: [message.record], recordIDsToDelete: nil)
        operation.savePolicy = .IfServerRecordUnchanged
        operation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordIDs, error in
            dispatch_async(dispatch_get_main_queue(), {
                completion(error)
            })
        }
        database.addOperation(operation)
    }
    
}
