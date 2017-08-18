//
//  GameViewController.swift
//  WCLive
//
//  Created by Joss Manger on 8/18/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

import UIKit
import GameKit

class GameViewController: UIViewController,GameAndWatchDelegate {

    override var shouldAutorotate:Bool {
        get{
            return true
        }
    }
    
    override var prefersStatusBarHidden:Bool {
        get{
            return true
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let scene = GKScene(fileNamed: "GameScene") else {
            fatalError("no scene")
        }
        
        let sceneNode = scene.rootNode as! GameScene
        
        sceneNode.entities = scene.entities
        sceneNode.graphs = scene.graphs
        
        sceneNode.scaleMode = .aspectFill
        
        let skView = self.view as! SKView
        
        skView.presentScene(sceneNode)
        
        skView.showsFPS = true;
        
        skView.showsNodeCount = true;
        
        // Do any additional setup after loading the view.
    }
    
    func sendMessage(str: String) {
        let skView = self.view as! SKView
        
        let scene = skView.scene as! GameScene
        
        scene.controls(str)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
