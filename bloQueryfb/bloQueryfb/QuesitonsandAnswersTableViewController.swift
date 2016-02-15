//
//  QuesitonsandAnswersTableViewController.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/15/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import Foundation


class QuesitonsandAnswersTableViewController: UITableViewController {

    var answers = [AnswerItem]()
    let ref = Firebase(url: "https://bloquery2fb.firebaseio.com/answer-items")
    let usersRef = Firebase(url: "https://bloquery2fb.firebaseio.com/online")
    var user: Users!
    var currentQuestion:QuestionItem?
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var object = currentQuestion {
            currentQuestionLabel.text = currentQuestion?.question
        }
    }
    
        
        // MARK: UITableView Delegate methods
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return answers.count
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell")! as! AnswersTableViewCell
            let answerItem = answers[indexPath.row]
            
            cell.textLabel?.text = answerItem.answer
            cell.detailTextLabel?.text = answerItem.addedByUser
            
            
            
            return cell
        }
        
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
        }
    @IBAction func addAnswer(sender: AnyObject) {
        var alert = UIAlertController(title: "Add an Answer",
            message: "think first!",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction) -> Void in
                
                // Get the text field for the item name
                let textField = alert.textFields![0]
                // Create the grocery item from the struct
                let answerItem = AnswerItem(answer: textField.text!, addedByUser: self.user.email, completed: false)
                
                // Create a child id from the item's name as a lowercase string
                let answerItemRef = self.ref.childByAppendingPath(textField.text!.lowercaseString)
                // Save the grocery items in its AnyObject form
                answerItemRef.setValue(answerItem.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }

    }
    



