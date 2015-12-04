//
//  DiscoverPeripheralDevicesTableViewController.swift
//  Control
//
//  Created by Davide Bruzzone on 11/22/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

import CoreBluetooth

class DiscoverPeripheralDevicesTableViewController: UITableViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    var centralManager: CBCentralManager?

    var peripherals: [CBPeripheral] = []

    var scanning: Bool = false

    // MARK: - Outlets
    @IBOutlet weak var scanBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

        centralManager = CBCentralManager.init(delegate: self, queue: nil, options: nil)
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
        return peripherals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let peripheral = peripherals[indexPath.row]

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
        if (scanning) {
            centralManager!.stopScan()

            scanBarButtonItem.title = "Scan"

            scanning = false
        } else {
            centralManager!.scanForPeripheralsWithServices(nil, options: nil)

            scanBarButtonItem.title = "Stop"

            scanning = true
        }
    }

    // MARK: - CBCentralManagerDelegate
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
            case CBCentralManagerState.PoweredOff:
                print("The device's Bluetooth hardware is powered off")
            case CBCentralManagerState.PoweredOn:
                print("The device's Bluetooth hardware is powered on and ready")

                scanBarButtonItem.enabled = true
            case CBCentralManagerState.Resetting:
                print("The Bluetooth hardware is resetting")
            case CBCentralManagerState.Unauthorized:
                print("The Bluetooth hardware's state is unauthorized")
            case CBCentralManagerState.Unknown:
                print("The Bluetooth hardware's state is unknown")
            case CBCentralManagerState.Unsupported:
                print("This device doesn't have Bluetooth hardware")
        }
    }

    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            
            self.tableView.reloadData()
        }
    }

}
