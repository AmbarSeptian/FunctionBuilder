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
    
    static func buildBlock(_ layouts: Layout...)-> VerticalLayout {
        return VerticalLayout(layout: layouts)
    }
    
    static func buildBlock(_ horizontals: Layout...)-> HorizontalLayout {
         return HorizontalLayout(layout: horizontals)
     }
    
}

class LayoutSpec: ASWrapperLayoutSpec {
    convenience init(@LayoutBuilder builder: () -> Layout) {
        self.init(layoutElement: builder().layoutSpec())
    }
}


protocol Layout {
    func layoutSpec() -> ASLayoutElement
}

extension Layout {
  
}

struct AnyLayout<T> {
    
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
    
    init(verticalLayout: VerticalLayout) {
        self.stack = verticalLayout.layoutSpec() as! ASStackLayoutSpec
    }
    
    init(@LayoutBuilder builder: () -> VerticalLayout) {
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
    
    init(verticalLayout: HorizontalLayout) {
        self.stack = verticalLayout.layoutSpec() as! ASStackLayoutSpec
    }
    
    init(@LayoutBuilder builder: () -> HorizontalLayout) {
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
//        return LayoutSpec {
            VerticalLayout {
                nodes[0]
                nodes[1]
                HorizontalLayout {
                    nodes[2]
                    nodes[3]
                }
                .spacing(10)
            }
            .spacing(40)
    .build()
//        }
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
