//
//  TextureBuilder.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 17/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import AsyncDisplayKit


struct AnyLayout {
    let content: ASLayoutElement
}

protocol Layout {
    associatedtype Element: ASLayoutElement
    func build() -> Element
}

protocol StackLayout: Layout {
    var stack: ASStackLayoutSpec { get }
    init(stack: ASStackLayoutSpec)
    init(layouts: [AnyLayout])
}

extension StackLayout {
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
}


struct VLayout: StackLayout, Layout {
    let stack: ASStackLayoutSpec
    init(layouts: [AnyLayout]) {
        self.stack = ASStackLayoutSpec.vertical()
        stack.children = layouts.map { $0.content }
    }
    
    init(stack: ASStackLayoutSpec) {
        self.stack = stack
    }
    
    init(@LayoutBuilder builder: () -> VLayout) {
        self.init(stack: builder().build())
    }
    
    func build() -> ASStackLayoutSpec {
        return stack
    }
}

struct HLayout: StackLayout, Layout {
    let stack: ASStackLayoutSpec
    init(layouts: [AnyLayout]) {
        self.stack = ASStackLayoutSpec.horizontal()
        stack.children = layouts.map { $0.content }
    }
    
    init(stack: ASStackLayoutSpec) {
        self.stack = stack
    }
    
    init(@LayoutBuilder builder: () -> HLayout) {
        self.init(stack: builder().build())
    }
    
    func build() -> ASStackLayoutSpec {
        return stack
    }
}

@_functionBuilder
struct LayoutBuilder {
    
    // MARK: Build Block
     static func buildBlock(_ layouts: AnyLayout...)-> VLayout {
         VLayout(layouts: layouts)
    }
     
     static func buildBlock(_ layouts: AnyLayout...)-> HLayout {
          HLayout(layouts: layouts)
     }
    
    static func buildBlock(_ layout: AnyLayout)-> AnyLayout {
         layout
    }
    
    // MARK: Build Expression
    static func buildExpression(_ layout: AnyLayout) -> AnyLayout {
       layout
   }
    
     static func buildExpression(_ layout: ASLayoutElement) -> AnyLayout {
        AnyLayout(content: layout)
    }
    
    static func buildExpression(_ layout: HLayout) -> AnyLayout {
        AnyLayout(content: layout.build())
    }
    
    static func buildExpression(_ layout: VLayout) -> AnyLayout {
        AnyLayout(content: layout.build())
    }
    
    // MARK: Build If
    static func buildIf(_ layout: AnyLayout?)-> AnyLayout {
        if let layoutSpec = layout {
            return layoutSpec
        }

        return AnyLayout(content: ASLayoutSpec())
    }
    
    static func buildEither(first layout: AnyLayout)-> AnyLayout {
        layout
    }
    
    static func buildEither(second layout: AnyLayout)-> AnyLayout {
        layout
    }
    
}
