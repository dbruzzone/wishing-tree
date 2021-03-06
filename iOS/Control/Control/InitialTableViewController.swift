//
//  InitialTableViewController.swift
//  Control
//
//  Created by Davide Bruzzone on 11/21/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

import CoreBluetooth

class InitialTableViewController: UITableViewController, PeripheralDelegate {

    var selectedPeripherals: [CBPeripheral] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPeripherals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let peripheral: CBPeripheral = selectedPeripherals[indexPath.row]
        
        cell.textLabel?.text = peripheral.name
        cell.detailTextLabel?.text = peripheral.description

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "PeripheralsSearchSegue" {
            if let destinationViewController = segue.destinationViewController as? UINavigationController {
                if let discoverPeripheralDevicesTableViewController = destinationViewController.viewControllers[0] as? DiscoverPeripheralDevicesTableViewController {
                        discoverPeripheralDevicesTableViewController.delegate = self
                }
            }
        } else if segue.identifier == "PeripheralSelectSegue" {
            if let destinationViewController = segue.destinationViewController as? PeripheralServicesTableViewController {
                let selectedRow = self.tableView.indexPathForSelectedRow!.row
    
                destinationViewController.selectedPeripheral = selectedPeripherals[selectedRow]
            }
        }
    }

    // MARK: - PeripheralSelectionDelegate

    func peripheralSelected(peripheral: CBPeripheral) {
        selectedPeripherals.append(peripheral)
    }

}
