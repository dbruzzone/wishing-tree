//
//  InitialTableViewController.swift
//  Time
//
//  Created by Davide Bruzzone on 10/10/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController {

    var activities =
        [ "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
          "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty"]

    var timer = NSTimer()

    var counter = 0

    let searchCharacter: Character = ":"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        self.title = "Time"

        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height

        self.tableView.contentInset = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0)

        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "logTime", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = activities[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func logTime() {
        let visibleIndexPaths = self.tableView.indexPathsForVisibleRows

        for visibleIndexPath in visibleIndexPaths! {
            let activity = activities[visibleIndexPath.row]

            // Update the activities that are currently visible in the table view...
            let searchCharacterIndex = activity.characters.indexOf(searchCharacter)

            if (searchCharacterIndex != nil) {
                // If the activity contains a ':', get all the its characters up to but not
                // including the ':'
                let beginning = activity.substringToIndex((searchCharacterIndex?.successor())!)

                activities[visibleIndexPath.row] = "\(beginning): \(String(counter))"
            } else {
                // If the activity doesn't contain a ':'...
                activities[visibleIndexPath.row] = "\(activity): \(String(counter))"
            }
        }

        self.tableView.reloadRowsAtIndexPaths(visibleIndexPaths!, withRowAnimation: UITableViewRowAnimation.None)
    }

}
