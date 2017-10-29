//
//  GameLayer.swift
//  StackIt
//
//  Created by Marcos Morais on 29/10/2017.
//  Copyright © 2017 Marcos Morais. All rights reserved.
//

import SceneKit

class GameLayer: SCNNode {

    var direction = BlockDirection.down
    var height = 0

    var previousSize = SCNVector3(1, 0.2, 1)
    var previousPosition = SCNVector3(0, 0.1, 0)
    var currentSize = SCNVector3(1, 0.2, 1)
    var currentPosition = SCNVector3Zero

    var offset = SCNVector3Zero
    var absoluteOffset = SCNVector3Zero
    var newSize = SCNVector3Zero
    
    var perfectMatches = 0
    
    override init() {
        super.init()
        
        createBlock()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Create Block
    
    func createBlock() {

        let blockNode = Block(box: SCNBox(width: 1, height: 0.2, length: 1, chamferRadius: 0), height: height)
        blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.01 * CGFloat(height), green: 0, blue: 1, alpha: 1)
        
        self.addChildNode(blockNode)
        
    }
    
    func addNewBlock(_ currentBoxNode: SCNNode) {
        let newBoxNode = SCNNode(geometry: currentBoxNode.geometry)
        newBoxNode.position = SCNVector3Make(currentBoxNode.position.x,
                                             currentPosition.y + 0.2, currentBoxNode.position.z)
        newBoxNode.name = "Block\(height+1)"
        newBoxNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.01 * CGFloat(height), green: 0, blue: 1, alpha: 1)
        
        if height % 2 == 0 {
            newBoxNode.position.x = -1.25
        } else {
            newBoxNode.position.z = -1.25
        }

        self.addChildNode(newBoxNode)
    }
    
    func addBrokenBlock(_ currentBoxNode: SCNNode) {
        let brokenBoxNode = SCNNode()
        brokenBoxNode.name = "Broken \(height)"
        
        if height % 2 == 0 && absoluteOffset.z > 0 {
            brokenBoxNode.geometry = SCNBox(width: CGFloat(currentSize.x),
                                            height: 0.2, length: CGFloat(absoluteOffset.z), chamferRadius: 0)
            if offset.z > 0 {
                brokenBoxNode.position.z = currentBoxNode.position.z -
                    (offset.z/2) - ((currentSize - offset).z/2)
            } else {
                brokenBoxNode.position.z = currentBoxNode.position.z -
                    (offset.z/2) + ((currentSize + offset).z/2)
            }
            brokenBoxNode.position.x = currentBoxNode.position.x
            brokenBoxNode.position.y = currentPosition.y

            brokenBoxNode.physicsBody = SCNPhysicsBody(type: .dynamic,
                                                       shape: SCNPhysicsShape(geometry: brokenBoxNode.geometry!, options: nil))
            brokenBoxNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.01 * CGFloat(height), green: 0, blue: 1, alpha: 1)
            self.addChildNode(brokenBoxNode)

        } else if height % 2 != 0 && absoluteOffset.x > 0 {
            brokenBoxNode.geometry = SCNBox(width: CGFloat(absoluteOffset.x), height: 0.2,
                                            length: CGFloat(currentSize.z), chamferRadius: 0)
            
            if offset.x > 0 {
                brokenBoxNode.position.x = currentBoxNode.position.x - (offset.x/2) -
                    ((currentSize - offset).x/2)
            } else {
                brokenBoxNode.position.x = currentBoxNode.position.x - (offset.x/2) +
                    ((currentSize + offset).x/2)
            }
            brokenBoxNode.position.y = currentPosition.y
            brokenBoxNode.position.z = currentBoxNode.position.z
            
            brokenBoxNode.physicsBody = SCNPhysicsBody(type: .dynamic,
                                                       shape: SCNPhysicsShape(geometry: brokenBoxNode.geometry!, options: nil))
            brokenBoxNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.01 * CGFloat(height), green: 0, blue: 1, alpha: 1)
            self.addChildNode(brokenBoxNode)
        }
    }
    
    func checkIfBlockIsInCorrectPlace() {
        if let currentBoxNode = self.childNode(withName: "Block\(height)", recursively: false) {
            currentPosition = currentBoxNode.presentation.position
            let boundsMin = currentBoxNode.boundingBox.min
            let boundsMax = currentBoxNode.boundingBox.max
            currentSize = boundsMax - boundsMin
            
            offset = previousPosition - currentPosition
            absoluteOffset = offset.absoluteValue()
            newSize = currentSize - absoluteOffset
            
            currentBoxNode.geometry = SCNBox(width: CGFloat(newSize.x), height: 0.2,
                                             length: CGFloat(newSize.z), chamferRadius: 0)
            currentBoxNode.position = SCNVector3Make(currentPosition.x + (offset.x/2),
                                                     currentPosition.y, currentPosition.z + (offset.z/2))
            currentBoxNode.physicsBody = SCNPhysicsBody(type: .static,
                                                        shape: SCNPhysicsShape(geometry: currentBoxNode.geometry!, options: nil))
            
            self.addNewBlock(currentBoxNode)
            addBrokenBlock(currentBoxNode)

            if height >= 5 {
                let moveUpAction = SCNAction.move(by: SCNVector3Make(0.0, 0.2, 0.0), duration: 0.2)
                let mainCamera = self.parent?.childNode(withName: "Camera", recursively: false)!
                mainCamera?.runAction(moveUpAction)
            }

            previousSize = SCNVector3Make(newSize.x, 0.2, newSize.z)
            previousPosition = currentBoxNode.position
            height += 1
            
        }
    }
    
}
