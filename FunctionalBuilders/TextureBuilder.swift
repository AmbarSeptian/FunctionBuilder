//
//  TextureBuilder.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 17/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import AsyncDisplayKit


struct AnyLayout<T: ASLayoutElement> {
    let content: T
}

struct VLayout: LT {
    let stack: ASStackLayoutSpec
    init(layouts: [AnyLayout<ASLayoutElement>]) {
        self.stack = ASStackLayoutSpec.vertical()
        stack.children = layouts.map { $0.content }
    }
    
    init(stack: ASStackLayoutSpec) {
        self.stack = stack
    }
    
    init(@LTBuilder builder: () -> VLayout) {
        self.init(stack: builder().build())
    }
    
    func build() -> ASStackLayoutSpec {
        return stack
    }
}

protocol LT {
    associatedtype Element: ASLayoutElement
    func build() -> Element
}

extension ASDisplayNode: LT {
    func build() -> ASDisplayNode {
        self
    }
}

@_functionBuilder
struct LTBuilder {
    static func buildExpression<ASLayoutElement>(_ layout: AnyLayout<ASLayoutElement>) -> AnyLayout<ASLayoutElement> {
       return layout
   }
    
     static func buildExpression(_ layout: ASLayoutElement) -> AnyLayout<ASLayoutElement> {
        return AnyLayout(content: layout)
    }
   
    static func buildBlock(_ layouts: AnyLayout<ASLayoutElement>...)-> VLayout {
        VLayout(layouts: layouts)
   }

}

class TextureBuildView2Controller: ASViewController<ASDisplayNode> {
    init() {
        let rootNode = ASDisplayNode()
        rootNode.automaticallyManagesSubnodes = true
        rootNode.backgroundColor = .white
        super.init(node: rootNode)
    
        let block = asdf()
        rootNode.layoutSpecBlock = { _, _ in
            return block
        }
        
        let node:AnyLayout<ASLayoutElement> = AnyLayout(content: ASDisplayNode())
        let asdf: [AnyLayout<ASLayoutElement>] = [node]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func asdf() -> ASLayoutSpec {
        let asdf = VLayout {
            nodes[0]
            nodes[1]
        }
        .build()
        return asdf
        
////            VerticalLayout {
////                ASDisplayNode()
////                ASDisplayNode()
////            }
//        }
//        .build()

    }
    
    let nodes: [ASDisplayNode] = {
        return [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)].map { color -> ASDisplayNode in
            let node = ASDisplayNode()
            node.backgroundColor = color
            node.style.preferredSize = CGSize(width: 50, height: 50)
            return node
        }
    }()
    
}
