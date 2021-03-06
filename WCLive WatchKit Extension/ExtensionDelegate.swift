//
//  ExtensionDelegate.swift
//  WCLive WatchKit Extension
//
//  Created by Joss Manger on 7/31/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate,WCSessionDelegate {
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        activateSession()
    }

    func activateSession(){
        if(WCSession.isSupported()){
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }

    }
    
    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        activateSession()
        
    }

    func applicationWillResignActive() {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompleted()
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompleted()
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompleted()
            default:
                // make sure to complete unhandled task types
                task.setTaskCompleted()
            }
        }
    }

}

extension ExtensionDelegate {
    /*WC Delegate*/
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState.rawValue)
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        print("messageData \(messageData)")
    }
    
    
    
    /*Custom*/
    
    func sendMessageToiOS<T>(_ a: T){
        print("will send message to iOS: \(a)")
        
        WCSession.default().sendMessage(["message":(a as! Directions).stringDescriptor()], replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    func replyHandler(_ response:[String:Any])->Void{
        print("response: \(response)")
    }
    
    func errorHandler(_ error:Error)->Void{
        print("error \(error)")
    }
}
