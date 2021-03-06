//
//  AppDelegate.swift
//  WCLive
//
//  Created by Joss Manger on 7/31/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit
import WatchConnectivity

protocol GameAndWatchDelegate {
    func sendMessage(str:String)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WCSessionDelegate {
    
    var window: UIWindow?

    var gameView:GameAndWatchDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if self.window?.rootViewController is ViewController{
            gameView = self.window?.rootViewController as? ViewController
        } else if self.window?.rootViewController is GameViewController{
            gameView = self.window?.rootViewController as? GameViewController
        }
        
        
        
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        
        
        
        return true
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("hello from delegate \(activationState.rawValue)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //print(message)
        //print("that was the message")
        DispatchQueue.main.async {
            if let vc = self.gameView{
                //vc.updateLabel(str: message["message"] as! String)
            
                vc.sendMessage(str: message["message"] as! String)
                
            }
        }
        
        
    }
    
    
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("inactivated")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("deactivated")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    
    

}



