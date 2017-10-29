//
//  Block.swift
//  StackIt
//
//  Created by Marcos Morais on 29/10/2017.
//  Copyright © 2017 Marcos Morais. All rights reserved.
//

import SceneKit

enum BlockDirection {
    case up
    case down
}

class Block: SCNNode {
    
    init(box: SCNBox, height: Int) {
        super.init()
        self.geometry = box
        
        self.position.z = -1.25
        self.position.y = 0.1
        
        self.name = "Block\(height)"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
