//
//  Users.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/14/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import Foundation

struct Users {
    let uid: String
    let email: String
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}