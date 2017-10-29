//
//  GameViewController.swift
//  StackIt
//
//  Created by Marcos Morais on 29/10/2017.
//  Copyright © 2017 Marcos Morais. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    let gameLayer = GameLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene(named: "StackIt.scnassets/Scenes/GameScene.scn")!
        sceneView.scene = scene
        sceneView.scene?.rootNode.addChildNode(self.gameLayer)
        
        sceneView.isPlaying = true
        sceneView.delegate = self
    
    }
    
    
    @IBAction func handleTapAction(_ sender: Any) {
        self.gameLayer.checkIfBlockIsInCorrectPlace()
        scoreLabel.text = "\(self.gameLayer.height)"
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
