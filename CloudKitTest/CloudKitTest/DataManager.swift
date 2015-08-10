//
//  DataManager.swift
//  CloudKitTest
//
//  Created by Mateusz Dzwonek on 30/06/2015.
//  Copyright © 2015 Mateusz Dzwonek. All rights reserved.
//

import Foundation

class DataManager {

    static let sharedInstance = DataManager()
    
    private var messages: [Message]
    
    init() {
        messages = []
    }
    
    func getMessagesWithCompletion(completion: ([Message]?, NSError?) -> Void) {
        completion(messages, nil)
    }
    
    func addMessage(message: Message, withCompletion completion: NSError? -> Void) {
        messages.append(message)
        completion(nil)
    }
    
}
