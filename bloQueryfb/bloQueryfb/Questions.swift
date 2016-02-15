//
//  Questions.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/14/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import Foundation

struct QuestionItem {
    
    let question: String!
    let key: String!
    let addedByUser: String!
    let ref: Firebase?
    var completed: Bool!
    
    // Initialize from arbitrary data
   // init(name: String, addedByUser: String, completed: Bool, key: String = "") {
    init(question: String, addedByUser: String, completed: Bool, key: String = "") {
        self.question = question
//self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.ref = nil
        self.key = key
    }
    
    init(snapshot: FDataSnapshot) {
        question = snapshot.key
        //name = snapshot.value["name"] as! String
        addedByUser = snapshot.value["addedByUser"] as! String
        completed = snapshot.value["completed"] as! Bool
        ref = snapshot.ref
        key = snapshot.key
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "question": question,
            "addedByUser": addedByUser,
            "completed": completed
        ]
    }
    
}
