//
//  QuestionTableViewController.swift
//  bloQueryfb
//
//  Created by Eric Chamberlin on 2/14/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit


class QuestionTableViewController: UITableViewController {

    var questions = [QuestionItem]()
    let ref = Firebase(url: "https://bloquery2fb.firebaseio.com/question-items")
    let usersRef = Firebase(url: "https://bloquery2fb.firebaseio.com/online")
    var user: Users!
    //var currentQuestion = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set up swipe to delete
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // [1] Call the queryOrderedByChild function to return a reference that queries by the "completed" property
        ref.queryOrderedByChild("completed").observeEventType(.Value, withBlock: { snapshot in
            
            var newItems = [QuestionItem]()
            
            for item in snapshot.children {
                
                let questionItem = QuestionItem(snapshot: item as! FDataSnapshot)
                newItems.append(questionItem)
            }
            
            self.questions = newItems
            self.tableView.reloadData()
        })
        
        ref.observeAuthEventWithBlock { authData in
            
            if authData != nil {
                
                self.user = Users(authData: authData)
            
                // Create a child reference with a unique id
                let currentUserRef = self.usersRef.childByAutoId()
                
                // Save the current user to the online users list
                currentUserRef.setValue(self.user.email)
                
                // When the user disconnects remove the value
                currentUserRef.onDisconnectRemoveValue()
            }
            
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    // MARK: UITableView Delegate methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell")! as UITableViewCell
        let questionItem = questions[indexPath.row]
        
        cell.textLabel?.text = questionItem.question
        cell.detailTextLabel?.text = questionItem.addedByUser
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Find the snapshot and remove the value
            let questionItem = questions[indexPath.row]
            
            // Using the optional ref property, remove the value from the database
            questionItem.ref?.removeValue()
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get the cell
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        // Get the associated grocery item
        let questionItem = questions[indexPath.row]
        //currentQuestion.description = questionItem.question
        
        // Get the new completion status
        let toggledCompletion = !questionItem.completed
        
        
        // Determine whether the cell is checked and modify it's view properties
        //toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        
        // Call updateChildValues on the grocery item's reference with just the new completed status
        questionItem.ref?.updateChildValues([
            "completed": toggledCompletion
            ])
    }
    
    // MARK: Add Item
    
    @IBAction func addButtonDidTouch(sender: AnyObject) {
        // Alert View for input
        var alert = UIAlertController(title: "New Question",
            message: "Add a good question",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction) -> Void in
                
                // Get the text field for the item name
                let textField = alert.textFields![0] 
                print(textField.text)
                // Create the grocery item from the struct
                let questionItem = QuestionItem(question: textField.text!, addedByUser: self.user.email, completed: false)
                
                // Create a child id from the item's name as a lowercase string
                let questionItemRef = self.ref.childByAppendingPath(textField.text!.lowercaseString)
                // Save the grocery items in its AnyObject form
                questionItemRef.setValue(questionItem.toAnyObject())
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nav = segue.destinationViewController as! UINavigationController
        let controller = nav.topViewController as! QuesitonsandAnswersTableViewController
        
        
        if segue.identifier == "ShowAnswers" {
            
            let indexPath = tableView.indexPathForSelectedRow
            
            
            let questionItem = questions[indexPath!.row]
            
            controller.currentQuestion = self.questions[(indexPath?.row)!]
            
            //resulted in carsh = nil value
            //controller.connectedAnswers = self.objects![indexPath!.row]
        }
   
    }
}




