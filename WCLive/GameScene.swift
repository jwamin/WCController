//
//  GameScene.swift
//  WCLive
//
//  Created by Joss Manger on 8/18/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit
import GameKit
class GameScene: SKScene,SKPhysicsContactDelegate {
    
    
    let playerBitMask:UInt32 = 1
    let collisionBitMask:UInt32 = 2
    var successfulPlays:Int = 0 {
        didSet{
            self.updateLabel()
        }
    }
    
    var gameIsOver = false
    
    var entities:[GKEntity] = []
    var graphs:[String:GKGraph] = [:]
    var runInt:Int = 0
    var player:SKShapeNode!
    var cage:SKShapeNode!
    var isAnimating = false;
    var distanceOffset:CGFloat = 100;
    var lineLength:CGFloat = 50;
    
    var label:SKLabelNode?
    
    override func sceneDidLoad() {
        
        scene?.physicsWorld.contactDelegate = self
        
//        let cagePath = CGMutablePath()
//        cagePath.move(to: CGPoint(x: -lineLength, y: -lineLength))
//        cagePath.addLine(to: CGPoint(x: -lineLength, y: lineLength))
//        cagePath.addLine(to: CGPoint(x: lineLength, y: lineLength))
//        cagePath.addLine(to: CGPoint(x: lineLength, y: -lineLength))
//   
      
    createSceneContents()
    
    }
    
    func createSceneContents() -> Void {
        let cageWall = CGSize(width: 5.0, height: 400)
        let cageTop = CGSize(width: 400, height: 5.0)
        
        label = SKLabelNode(text: "")
        label?.position = CGPoint(x: 0, y: 0)
        guard let label = label else {
            fatalError()
        }
        
        
        
        scene?.addChild(label)
        
        runInt+=1
        print("hello world",runInt)
        
        
        
        guard let confirmplayer = self.childNode(withName: "player"), let cageGroup = self.childNode(withName: "cageParent") else {
            fatalError("nothing there")
        }
        
        let wall1 = SKShapeNode(rectOf: cageWall)
        wall1.fillColor = .white
        wall1.position = CGPoint(x: -200, y: 0.0)
        wall1.physicsBody = SKPhysicsBody(rectangleOf: cageWall)
        wall1.physicsBody?.categoryBitMask = collisionBitMask
        wall1.physicsBody?.contactTestBitMask = playerBitMask
        wall1.physicsBody?.collisionBitMask = playerBitMask
        wall1.physicsBody?.affectedByGravity = false;
        //wall1.physicsBody?.pinned = true
        cageGroup.addChild(wall1)
        let wall2 = SKShapeNode(rectOf: cageTop)
        wall2.fillColor = .white
        wall2.position = CGPoint(x: 0.0, y: 200)
        wall2.physicsBody = SKPhysicsBody(rectangleOf: cageTop)
        wall2.physicsBody?.categoryBitMask = collisionBitMask
        wall2.physicsBody?.contactTestBitMask = playerBitMask
        wall2.physicsBody?.collisionBitMask = playerBitMask
        wall2.physicsBody?.affectedByGravity = false;
        //wall2.physicsBody?.pinned = true
        cageGroup.addChild(wall2)
        let wall3 = SKShapeNode(rectOf: cageWall)
        wall3.fillColor = .white
        wall3.position = CGPoint(x: 200, y: 0.0)
        wall3.physicsBody = SKPhysicsBody(rectangleOf: cageWall)
        wall3.physicsBody?.categoryBitMask = collisionBitMask
        wall3.physicsBody?.contactTestBitMask = playerBitMask
        wall3.physicsBody?.collisionBitMask = playerBitMask
        wall3.physicsBody?.affectedByGravity = false;
        //wall3.physicsBody?.pinned = true
        cageGroup.addChild(wall3)
        
        
        player = confirmplayer as! SKShapeNode
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size)
        player.physicsBody?.categoryBitMask = playerBitMask
        player.physicsBody?.contactTestBitMask = collisionBitMask
        player.physicsBody?.collisionBitMask = collisionBitMask
        player.physicsBody?.affectedByGravity = false;
        player.physicsBody?.isDynamic = false
        
        
        //cage = confirmcage as! SKShapeNode
        //player.position = CGPoint(x: CGFloat(0.0), y: gameScreen.bounds.maxY - distanceOffset)
        //cage.path = cagePath
        //cage.lineWidth = 1.0
        //cage.strokeColor = .white
        //cage.fillColor = .blue
        
        
        //cage.physicsBody = SKPhysicsBody(rectangleOf: cage.frame.size)
        //cage.physicsBody?.categoryBitMask = collisionBitMask
        //cage.physicsBody?.pinned = true
        //cage.physicsBody?.allowsRotation = true
        //cage.physicsBody?.contactTestBitMask = playerBitMask
        //cage.physicsBody?.collisionBitMask = playerBitMask
        //cage.physicsBody?.affectedByGravity = false;
        //cage.physicsBody?.isDynamic = false;
        
        let rotationAction = SKAction.sequence([
            SKAction(named: "action")!,
            SKAction.repeatForever(SKAction.rotate(byAngle: .pi/4, duration: 1.0))
            ])
        
        player.run(rotationAction)
        cageGroup.run(SKAction.repeatForever(SKAction.rotate(byAngle: -.pi/2, duration: 1.0)))

    }
    
    func updateLabel(){
        label?.text = "\(successfulPlays) successful plays"
    }
    
    func performAnimation(_ direction:Directions){
        
        var point:CGPoint = player.position
        
        guard let gameScreen = self.view else {
            fatalError()
        }
        
        switch direction {
        case .up:
            point = CGPoint(x: CGFloat(0.0), y: gameScreen.bounds.maxY - distanceOffset)
        case .down:
            point = CGPoint(x: CGFloat(0.0), y: -gameScreen.bounds.maxY + distanceOffset)
        case .left:
            point = CGPoint(x: -gameScreen.bounds.maxX + distanceOffset, y: CGFloat(0.0))
        case .right:
            point = CGPoint(x: gameScreen.bounds.maxX - distanceOffset, y: CGFloat(0.0))
        case .center:
            point = CGPoint(x: 0, y: 0)
        case .downleft:
            point = CGPoint(x: -gameScreen.bounds.maxX + distanceOffset, y: -gameScreen.bounds.maxY + distanceOffset)
        case .downright:
            point = CGPoint(x: gameScreen.bounds.maxX - distanceOffset, y: -gameScreen.bounds.maxY + distanceOffset)
        case .upright:
            point = CGPoint(x: gameScreen.bounds.maxX - distanceOffset, y: gameScreen.bounds.maxY - distanceOffset)
        case .upleft:
            point = CGPoint(x: -gameScreen.bounds.maxX + distanceOffset, y: gameScreen.bounds.maxY - distanceOffset)
        }
        
        //print(point)
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
                self.successfulPlays += 1
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("some collision somewhere", contact)
        gameIsOver = true
        self.view?.isPaused = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(gameIsOver){
            NotificationCenter.default.post(name: Notification.Name("gameOver"), object: nil)
        } else {
            print("not game over")
        }
    }
    
    func controls(_ str:String) -> Void {
        
        
        let chosenDirection:Directions = Directions.stringDecoder(str)
        performAnimation(chosenDirection)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    deinit {
        print("self deinitialised")
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
