//
//  Answers.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/15/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import Foundation

struct AnswerItem {
    
    let answer: String!
    let key: String!
    let addedByUser: String!
    let ref: Firebase?
    var completed: Bool!
    
    // Initialize from arbitrary data
  
    init(answer: String, addedByUser: String, completed: Bool, key: String = "") {
        self.answer = answer
        //self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.ref = nil
        self.key = key
    }
    
    init(snapshot: FDataSnapshot) {
        answer = snapshot.key
        //name = snapshot.value["name"] as! String
        addedByUser = snapshot.value["addedByUser"] as! String
        completed = snapshot.value["completed"] as! Bool
        ref = snapshot.ref
        key = snapshot.key
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "answer": answer,
            "addedByUser": addedByUser,
            "completed": completed
        ]
    }
    
}

