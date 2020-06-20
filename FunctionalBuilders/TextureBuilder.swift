//
//  TextureBuilder.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 17/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import AsyncDisplayKit

@_functionBuilder
struct LayoutBuilder {
    static func buildExpression(_ layout: Layout) -> Layout {
        return layout
    }
    
    static func buildBlock(_ layouts: Layout...) -> Layout {
        return VerticalLayout(layout: layouts)
    }
}


protocol Layout {
    func layoutSpec() -> ASLayoutElement
}
extension Layout {
  
}

protocol StackLayout: Layout {

}


extension ASDisplayNode: Layout {
    func layoutSpec() -> ASLayoutElement {
        return self
    }
    
}

extension ASStackLayoutSpec: Layout {
    func layoutSpec() -> ASLayoutElement {
         return self
     }
}

struct VerticalLayout: StackLayout {
    func layoutSpec() -> ASLayoutElement {
        return stack
    }
    
    private var stack = ASStackLayoutSpec()
    
    init(layout: [Layout]) {
        self.stack = ASStackLayoutSpec.vertical()
        self.stack.children = layout.map { $0.layoutSpec() }
    }
    
    init(verticalLayout: Layout) {
        self.stack = verticalLayout.layoutSpec() as! ASStackLayoutSpec
    }
    
    init(@LayoutBuilder builder: () -> Layout) {
        self.init(verticalLayout: builder())
    }
    
    func spacing(_ spacing: CGFloat) -> Self {
        self.stack.spacing = spacing
        return self
    }
    
    func alignItems(_ alignItems: ASStackLayoutAlignItems) -> Self {
        self.stack.alignItems = alignItems
        return self
    }
    
    func justifyContent(_ justifyContent: ASStackLayoutJustifyContent) -> Self {
         self.stack.justifyContent = justifyContent
         return self
     }
    
    func build() -> ASLayoutSpec {
        return stack
    }
}

struct HorizontalLayout: StackLayout {
    func layoutSpec() -> ASLayoutElement {
        return stack
    }
    
    private var stack = ASStackLayoutSpec()
    
    init(layout: [Layout]) {
        self.stack = ASStackLayoutSpec.horizontal()
        self.stack.children = layout.map { $0.layoutSpec() }
    }
    
    init(verticalLayout: Layout) {
        self.stack = verticalLayout.layoutSpec() as! ASStackLayoutSpec
    }
    
    init(@LayoutBuilder builder: () -> Layout) {
        self.init(verticalLayout: builder())
    }
    
    func spacing(_ spacing: CGFloat) -> Self {
        self.stack.spacing = spacing
        return self
    }
    
    func alignItems(_ alignItems: ASStackLayoutAlignItems) -> Self {
        self.stack.alignItems = alignItems
        return self
    }
    
    func justifyContent(_ justifyContent: ASStackLayoutJustifyContent) -> Self {
         self.stack.justifyContent = justifyContent
         return self
     }
    
    func build() -> ASLayoutSpec {
        return stack
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func asdf() -> ASLayoutSpec {
        let node1 = ASDisplayNode()
        node1.backgroundColor = .blue
        node1.style.preferredSize = CGSize(width: 50, height: 50)
        
        let node2 = ASDisplayNode()
        node2.backgroundColor = .red
        node2.style.preferredSize = CGSize(width: 50, height: 50)
        
        let node3 = ASDisplayNode()
        node3.backgroundColor = .green
        node3.style.preferredSize = CGSize(width: 50, height: 50)
        
        let node4 = ASDisplayNode()
        node4.backgroundColor = .orange
        node4.style.preferredSize = CGSize(width: 50, height: 50)
        
        return VerticalLayout {
            node1
            node2
            HorizontalLayout {
                node3
                node4
            }
            .spacing(5)
        }
        .alignItems(.center)
        .justifyContent(.center)
        .spacing(40)
        .build()
    }
    
}
