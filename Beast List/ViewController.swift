//
//  ViewController.swift
//  Beast List
//
//  Created by Maric Sobreo on 1/12/16.
//  Copyright © 2016 Maric Sobreo (Coding Dojo). All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tasks = Task.all()
    
    @IBOutlet weak var insertTaskField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func insertButtonPressed(sender: UIButton) {
        if insertTaskField?.text != "" {
            // Create new task
            let task = Task(obj: insertTaskField.text!)
            // Save new tasks -> also appends the task to task array
            task.save()
            insertTaskField.text = nil
            tableView.reloadData()
        }
    }
    
    // How many cells are we going need?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks = Task.all()
        return tasks.count
        // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
        // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    }
    
    // What cell should I display for each row?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = tasks[indexPath.row].objective
        // return cell so that the Table view knows what to draw in each rowe
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Section: \(indexPath.section) and Row: \(indexPath.row)")
        // tasks is a reference to the database, so this should remove straight from the database
        print(tasks[indexPath.row].objective)
        tasks.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tasks = Task.all()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

