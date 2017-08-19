//
//  GameScene.swift
//  WCLive
//
//  Created by Joss Manger on 8/18/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit
import GameKit
class GameScene: SKScene {
    
    var entities:[GKEntity] = []
    var graphs:[String:GKGraph] = [:]
    var runInt:Int = 0
    var player:SKShapeNode!
    var isAnimating = false;
    
    var distanceOffest:CGFloat = 100;
    
    override func sceneDidLoad() {
        runInt+=1
        print("hello world",runInt)
        guard let confirmplayer = self.childNode(withName: "player") else {
            fatalError("nothing there")
        }
        
        player = confirmplayer as! SKShapeNode
        print(player.positionInScene)
        
        
        let rotationAction = SKAction.sequence([
            SKAction(named: "action")!,
            SKAction.repeatForever(SKAction.rotate(byAngle: .pi/4, duration: 1.0))
            ])
        
        player.run(rotationAction)
        
    }
    
    func performAnimation(_ direction:Directions){
        
        var point:CGPoint = player.position
        
        guard let gameScreen = self.view else {
            fatalError()
        }
        
        switch direction {
        case .up:
            point = CGPoint(x: CGFloat(0.0), y: gameScreen.bounds.maxY - distanceOffest)
        case .down:
            point = CGPoint(x: CGFloat(0.0), y: -gameScreen.bounds.maxY + distanceOffest)
        case .left:
            point = CGPoint(x: -gameScreen.bounds.maxX + distanceOffest, y: CGFloat(0.0))
        case .right:
            point = CGPoint(x: gameScreen.bounds.maxX - distanceOffest, y: CGFloat(0.0))
        case .center:
            point = CGPoint(x: 0, y: 0)
        case .downleft:
            point = CGPoint(x: -gameScreen.bounds.maxX + distanceOffest, y: -gameScreen.bounds.maxY + distanceOffest)
        case .downright:
            point = CGPoint(x: gameScreen.bounds.maxX - distanceOffest, y: -gameScreen.bounds.maxY + distanceOffest)
        case .upright:
            point = CGPoint(x: gameScreen.bounds.maxX - distanceOffest, y: gameScreen.bounds.maxY - distanceOffest)
        case .upleft:
            point = CGPoint(x: -gameScreen.bounds.maxX + distanceOffest, y: gameScreen.bounds.maxY - distanceOffest)
        }
        
        print(point)
        //Switch for direction
        if (!isAnimating){
            isAnimating = true
            let action = SKAction.move(to: point,
                                       duration: 1.0)
//            action.timingFunction = {
//                time in
//                return Float(GameScene.timing(t: Double(time), b: 0, c: 1, d: 1.0))
//            }
            
            action.timingMode = .easeInEaseOut
            
            player.run(action){
                self.isAnimating = false
            }
        }
        
       
        
        
    }
    
//    static func timing(t:Double, b:Double, c:Double, d:Double) -> Double{
//        var s:Double=1.70158;
//        var p:Double=0;
//        var a:Double=c;
//        if (t==0){
//            return b;
//        }
//        if ((t/d)==1){
//            return b+c;
//        }
//        if (p == 0){
//            p = d * 0.3;
//        }
//        if (a < abs(c)) {
//            a=c;
//            var s=p/4;
//        } else {
//            var s = p/(2 * .pi) * asin(c/a);
//            return a*pow(2,-10 * t) * sin( (t*d-s)*(2 * .pi)/p ) + c + b;
//        }
//        return 0.0
//    }
    
    //    easeOutElastic: function (x, t, b, c, d) {
    //    var s=1.70158;var p=0;var a=c;
    //    if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
    //    if (a < Math.abs(c)) { a=c; var s=p/4; }
    //    else var s = p/(2*Math.PI) * Math.asin (c/a);
    //    return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
    //    }
    //
    
    func controls(_ str:String) -> Void {
        
        
        let chosenDirection:Directions = Directions.stringDecoder(str)
        performAnimation(chosenDirection)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}


extension SKNode {
    var positionInScene:CGPoint? {
        if let scene = scene, let parent = parent {
            return parent.convert(position, to:scene)
        } else {
            return nil
        }
    }
}
