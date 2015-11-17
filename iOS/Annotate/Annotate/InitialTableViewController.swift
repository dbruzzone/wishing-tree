//
//  InitialTableViewController.swift
//  Annotate
//
//  Created by Davide Bruzzone on 11/6/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

import CoreData

import MediaPlayer

class InitialTableViewController: UITableViewController, MPMediaPickerControllerDelegate {

    var mediaItems = [MediaItem]()

    var mediaPickerController: MPMediaPickerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) { super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "MediaItem")

        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)

            mediaItems = results as! [MediaItem]
        } catch let error as NSError {
            print("Could not fetch the app's media items: \(error), \(error.userInfo)")
        }
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
        return mediaItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = mediaItems[indexPath.row].title

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

    @IBAction func addMediaItem(sender: AnyObject) {
        // TODO: Filter the media types that mediaPickerController displays. This used
        //       to work but nothing shows up now unless the filter is broadened to
        //       something like .AnyAudio
        mediaPickerController = MPMediaPickerController(mediaTypes: .AnyAudio)

        if let picker = mediaPickerController {
            picker.delegate = self
            picker.allowsPickingMultipleItems = true

            presentViewController(picker, animated: true, completion: nil)
        } else {
            // TODO
            print("Could not instantiate a media picker")
        }
    }

    // MARK: - MPMediaPickerControllerDelegate

    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let entity = NSEntityDescription.entityForName("MediaItem", inManagedObjectContext:managedContext)
    
        for selectedMediaItem in mediaItemCollection.items as [MPMediaItem] {
            let mediaItem = MediaItem(entity: entity!, insertIntoManagedObjectContext: managedContext)

            let itemUrl = selectedMediaItem.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
            let itemTitle = selectedMediaItem.valueForProperty(MPMediaItemPropertyTitle) as? String
            let itemArtist = selectedMediaItem.valueForProperty(MPMediaItemPropertyArtist) as? String

            mediaItem.url = itemUrl?.absoluteString
            mediaItem.title = itemTitle
            mediaItem.artist = itemArtist

            mediaItems.append(mediaItem)
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save the selected media item: \(error), \(error.userInfo)")
        }

        self.tableView.reloadData()

        mediaPicker.dismissViewControllerAnimated(true, completion: nil)
    }

    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        mediaPickerController!.dismissViewControllerAnimated(true, completion: nil)
    }

}
