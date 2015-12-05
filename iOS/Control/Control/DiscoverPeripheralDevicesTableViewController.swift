//
//  DiscoverPeripheralDevicesTableViewController.swift
//  Control
//
//  Created by Davide Bruzzone on 11/22/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

class DiscoverPeripheralDevicesTableViewController: UITableViewController, BluetoothManagerProtocol {

    var bluetoothManager: BluetoothManager?

    // MARK: - Outlets

    @IBOutlet weak var scanBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        bluetoothManager = BluetoothManager.sharedInstance

        bluetoothManager?.delegate = self
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
        return (bluetoothManager?.peripherals.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let peripheral = bluetoothManager!.peripherals[indexPath.row]

        // Safely unwrap peripheral.name before using it
        if let peripheralName = peripheral.name {
            cell.textLabel?.text = peripheralName
        }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Actions

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func scan(sender: AnyObject) {
        if let manager = bluetoothManager {
            if (manager.scanning) {
                manager.stopScanning()
                
                scanBarButtonItem.title = "Scan"
            } else {
                manager.scan()
                
                scanBarButtonItem.title = "Stop"
            }
        }
    }

    // MARK: - BluetoothManagerProtocol

    func hardwareReady() {
        scanBarButtonItem.enabled = true
    }

    func peripheralAdded() {
        self.tableView.reloadData()
    }

}
