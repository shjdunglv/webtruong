//
//  ChatViewController.swift
//  RaoViet
//
//  Created by Chung on 12/13/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {
    
//    static let SERVER = "http://117.6.131.222:8080/websync.ashx"
//    
//    var client: FMWebSyncClient?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
////        run()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.navigationItem.title = "CHAT"
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
////    func run() {
////        //create client
//        client = FMWebSyncClient(requestUrl: ChatViewController.SERVER)
//        //connect clinet to server
//        
//        let connectArgs = FMWebSyncConnectArgs.getConnectArgs()
//        connectArgs?.setOnSuccessBlock { (args) in
//            print("-- Connected to WebSync -- \(args)")
//        }
//        
//        connectArgs?.setOnFailureBlock { (args) in
//           print("-- Could not connect to WebSync -- \(args)")
//        }
//
//        connectArgs?.setOnStreamFailureBlock({ (error) in
//            print("-- Temporary stream failure. Reconnecting... -- \(error)")
//        })
//        
//        client.connect(with: connectArgs)
//
//
//        
//        //subScribe to  receive message
//        let subscribeArgs = FMWebSyncSubscribeArgs(channel: "/test")
//        subscribeArgs?.setOnSuccessBlock({ (msg) in
//            print("Subscribed to /test.")
//        })
//        subscribeArgs?.setOnFailureBlock({ (error) in
//            print("Could not subscribe to /test.")
//            print(error as Any)
//        })
//        subscribeArgs?.setOnReceive({ (msg) in
//            print("Received a message!")
//            print(msg?.dataJson as Any)
//        })
//        client.subscribe(with: subscribeArgs)
//        
//        
//        // public to subscribed to channel
//        
//        let publicArgs = FMWebSyncPublishArgs(channel: "/test", dataJson: "{\"message\":\"Hello, this is WebSync.\"}")
//        publicArgs?.setOnSuccessBlock({ (msg) in
//            print("Publish3057ed to /test.")
//        })
//        publicArgs?.setOnFailureBlock({ (error) in
//            print("Could not publish to /test.")
//            print(error as Any)
//        })
//        
//        client.publish(with: publicArgs)
//    }
    
    
}
