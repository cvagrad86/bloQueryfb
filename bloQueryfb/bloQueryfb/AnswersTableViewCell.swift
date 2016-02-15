//
//  AnswersTableViewCell.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/15/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import Foundation


class AnswersTableViewCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var votesLabel: UILabel!
    @IBAction func voteAdded(sender: AnyObject) {
        print("Vote added")
        
    }
    @IBAction func voteRemoved(sender: AnyObject) {
        print("Vote removed")
        
    }
}
