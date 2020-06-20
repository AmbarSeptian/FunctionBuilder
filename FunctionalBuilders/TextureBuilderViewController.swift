//
//  TextureViewController.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 17/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import AsyncDisplayKit

class TextureBuildViewController: ASViewController<ASDisplayNode> {
    init() {
        let rootNode = ASDisplayNode()
        rootNode.automaticallyManagesSubnodes = true
        super.init(node: rootNode)
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

