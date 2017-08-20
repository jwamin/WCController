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
    var cageGroup:SKShapeNode!
    var isAnimating = false;
    var distanceOffset:CGFloat = 100;
    var lineLength:CGFloat = 50;
    var directionState:Directions = .center
    var label:SKLabelNode?
    
    override func sceneDidLoad() {
        
        scene?.physicsWorld.contactDelegate = self
        

      
    createSceneContents()
    
    }
    
    func createSceneContents() -> Void {
        
        
        //Create label
        label = SKLabelNode(text: "")
        label?.position = CGPoint(x: 0, y: 0)

        //guard test existing scene entities from scene designer file
        guard let confirmplayer = self.childNode(withName: "player"), let cageGroup = self.childNode(withName: "cageParent"), let action = SKAction(named: "action"), let label = label else {
            fatalError("content missing there")
        }
        
        scene?.addChild(label)
        
        self.cageGroup = cageGroup as! SKShapeNode
        
        //plot three sided square
        let cagePath = CGMutablePath()
        cagePath.move(to: CGPoint(x: -cageGroup.frame.height, y: -cageGroup.frame.height))
        cagePath.addLine(to: CGPoint(x: -cageGroup.frame.height, y: cageGroup.frame.height))
        cagePath.addLine(to: CGPoint(x: cageGroup.frame.height, y: cageGroup.frame.height))
        cagePath.addLine(to: CGPoint(x: cageGroup.frame.height, y: -cageGroup.frame.height))
        //cagePath.closeSubpath() //goes back to start of path, unwanted for this
        
        //create shape
        let cage = SKShapeNode(path: cagePath)
        cage.lineWidth = 5.0
        cage.lineJoin = .round
        
        //configure physics for cage
        cage.physicsBody = SKPhysicsBody(edgeChainFrom: cagePath)
        cage.physicsBody?.categoryBitMask = collisionBitMask
        cage.physicsBody?.contactTestBitMask = playerBitMask
        cage.physicsBody?.collisionBitMask = playerBitMask
        cage.physicsBody?.affectedByGravity = false;
        cageGroup.addChild(cage)
        
        
        //get confirmed player div
        player = confirmplayer as? SKShapeNode
        print(player)
        //setup physics for player square
        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size)
        player.physicsBody?.categoryBitMask = playerBitMask
        player.physicsBody?.contactTestBitMask = collisionBitMask
        player.physicsBody?.collisionBitMask = collisionBitMask
        player.physicsBody?.affectedByGravity = false;
        
        
        //set actions for elements
        
        let rotationAction = SKAction.sequence([
            action,
            SKAction.repeatForever(SKAction.rotate(byAngle: .pi/4, duration: 1.0))
            ])
        
        let reverserotationAction = SKAction.sequence([
            action,
            SKAction.repeatForever(SKAction.rotate(byAngle: -.pi/2, duration: 1.0))
            ])
        
        //rotates plater
        player.run(rotationAction)
        //rotates 'cage'
        cageGroup.run(reverserotationAction)

    }
    
    //didSet method for score incrementer
    func updateLabel(){
        label?.text = "\(successfulPlays) successful plays"
    }
    
    
    //move player with control from AW
    
    func performAnimation(_ direction:Directions){
        
        var point:CGPoint = player.position
        print(cageGroup.frame)
        print(player.frame)
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
        
        //Switch for direction
        if (!isAnimating && (direction != directionState)){
            isAnimating = true
            let action = SKAction.move(to: point,
                                       duration: 1.0)
            
//            action.timingFunction = {
//                time in
//                return Float(GameScene.timing(t: Double(time), b: 0, c: 1, d: 1.0))
//            }
            
            action.timingMode = .easeInEaseOut
            
            player.run(action){
                self.directionState = direction
                self.isAnimating = false
                self.successfulPlays += 1
            }
        } else {
            print("either is till animating or trying to move to current direction state")
        }
        
       
        
        
    }
    
    //experimental over-easing timing function, crudely adapted from javascript, and currently not working
    
    //original JS Code
    //        easeOutElastic: function (x, t, b, c, d) {
    //        var s=1.70158;var p=0;var a=c;
    //        if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
    //        if (a < Math.abs(c)) { a=c; var s=p/4; }
    //        else var s = p/(2*Math.PI) * Math.asin (c/a);
    //        return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
    //        }
    
    
    //swift conversion
    static func timing(t:Double, b:Double, c:Double, d:Double) -> Double{
        var s:Double=1.70158;
        var p:Double=0;
        var a:Double=c;
        if (t==0){
            return b;
        }
        if ((t/d)==1){
            return b+c;
        }
        if (p == 0){
            p = d * 0.3;
        }
        if (a < abs(c)) {
            a=c;
            let s=p/4;
        } else {
            let s = p/(2 * .pi) * asin(c/a);
            return a*pow(2,-10 * t) * sin( (t*d-s)*(2 * .pi)/p ) + c + b;
        }
        return 0.0
    }
    

    //collisions
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("some collision somewhere", contact)
        gameIsOver = true
        self.view?.isPaused = true
    }
    
    //touch events
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(gameIsOver){
            
            //
            NotificationCenter.default.post(name: Notification.Name("gameOver"), object: nil)
        } else {
            print("not game over")
        }
    }
    
    
    func controls(_ str:String) -> Void {
        
        
        let chosenDirection:Directions = Directions.stringDecoder(str)
        performAnimation(chosenDirection)
    }
    
    //test deinit
    
    deinit {
        print("self deinitialised")
    }
    
}

//Extension

extension SKNode {
    var positionInScene:CGPoint? {
        if let scene = scene, let parent = parent {
            return parent.convert(position, to:scene)
        } else {
            return nil
        }
    }
}
