//
//  GameViewController+ SCNSceneRendererDelegate.swift
//  StackIt
//
//  Created by Marcos Morais on 29/10/2017.
//  Copyright © 2017 Marcos Morais. All rights reserved.
//

import SceneKit

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {

        if let currentNode = gameLayer.childNode(withName: "Block\(gameLayer.height)", recursively: false) {

            if gameLayer.height % 2 == 0 {
                if currentNode.position.z >= 1.25 {
                    gameLayer.direction = BlockDirection.down
                } else if currentNode.position.z <= -1.25 {
                    gameLayer.direction = BlockDirection.up
                }
                switch gameLayer.direction {
                case .up:
                    currentNode.position.z += 0.03
                case .down:
                    currentNode.position.z -= 0.03
                }

            } else {
                if currentNode.position.x >= 1.25 {
                    gameLayer.direction = BlockDirection.down
                } else if currentNode.position.x <= -1.25 {
                    gameLayer.direction = BlockDirection.up
                }
                
                switch gameLayer.direction {
                case .up:
                    currentNode.position.x += 0.03
                case .down:
                    currentNode.position.x -= 0.03
                }
            }
        }
        
        for node in self.gameLayer.childNodes {
            if node.presentation.position.y <= -20 {
                node.removeFromParentNode()
            }
        }
    }
}

