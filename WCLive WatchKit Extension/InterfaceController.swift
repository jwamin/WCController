//
//  InterfaceController.swift
//  WCLive WatchKit Extension
//
//  Created by Joss Manger on 7/31/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

enum Directions {
    
    case down
    case right
    case up
    case left
    case center
    case upright
    case upleft
    case downright
    case downleft
    
    func stringDescriptor()->String{
        switch self {
        case .up:
            return "⬆️"
        case .down:
            return "⬇️"
        case .left:
            return "⬅️"
        case .right:
            return "➡️"
        case .center:
            return "⏺"
        case .downleft:
            return "↙️"
        case .downright:
            return "↘️"
        case .upright:
            return "↗️"
        case .upleft:
            return "↖️"
        }
        
    }
    
}

class InterfaceController: WKInterfaceController,WKCrownDelegate {

    let delegate:ExtensionDelegate = WKExtension.shared().delegate! as! ExtensionDelegate

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.delegate = self
        crownSequencer.focus()
        
        // Configure interface objects here.
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        print(rotationalDelta)
    }
    
    func crownDidBecomeIdle(_ crownSequencer: WKCrownSequencer?) {
        print("idle",crownSequencer?.rotationsPerSecond)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func down() {
        receivedDirection(direction: .down)
    }
    @IBAction func right() {
        receivedDirection(direction: .right)
    }
    @IBAction func left() {
        receivedDirection(direction: .left)
    }
    @IBAction func up() {
        receivedDirection(direction: .up)
    }
    @IBAction func downleft() {
        receivedDirection(direction: .downleft)
    }
    @IBAction func downright() {
        receivedDirection(direction: .downright)
    }
    @IBAction func upright() {
        receivedDirection(direction: .upright)
    }
    @IBAction func upleft() {
        receivedDirection(direction: .upleft)
    }
    @IBAction func center() {
        receivedDirection(direction: .center)
    }
    
    func receivedDirection(direction:Directions){
        print(direction)
        delegate.sendMessageToiOS(direction)
    }
    
}
