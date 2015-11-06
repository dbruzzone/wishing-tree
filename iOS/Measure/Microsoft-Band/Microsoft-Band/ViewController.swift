//
//  ViewController.swift
//  Microsoft-Band
//
//  Created by Davide Bruzzone on 11/4/15.
//  Copyright © 2015 Bitwise Samurai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MSBClientManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let sharedManager = MSBClientManager.sharedManager()

        sharedManager.delegate = self

        let attachedClients = sharedManager.attachedClients()

        if attachedClients.count == 1 {
            let client = attachedClients.first as! MSBClient

            sharedManager.connectClient(client)
        } else {
            // TODO
            for attachedClient in attachedClients {
                print("Client name/description: \(attachedClient.name)/\(attachedClient.description)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - MSBClientManagerDelegate
    
    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        print("clientDidConnect")
    }

    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
        print("clientDidDisconnect")
    }

    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        print("clientDidFailToConnectWithError")
    }

}
