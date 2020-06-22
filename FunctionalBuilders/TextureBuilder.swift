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

protocol Layout {
    associatedtype Element: ASLayoutElement
    func build() -> Element
}

protocol StackLayout: Layout {
    var stack: ASStackLayoutSpec { get }
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


struct VLayout: StackLayout {
    let stack: ASStackLayoutSpec
    init(layouts: [AnyLayout<ASLayoutElement>]) {
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

struct HLayout: StackLayout {
    let stack: ASStackLayoutSpec
    init(layouts: [AnyLayout<ASLayoutElement>]) {
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
     static func buildBlock(_ layouts: AnyLayout<ASLayoutElement>...)-> VLayout {
         VLayout(layouts: layouts)
    }
     
     static func buildBlock(_ layouts: AnyLayout<ASLayoutElement>...)-> HLayout {
          HLayout(layouts: layouts)
     }
    
    // MARK: Build Expression
    static func buildExpression(_ layout: AnyLayout<ASLayoutElement>) -> AnyLayout<ASLayoutElement> {
       return layout
   }
    
     static func buildExpression(_ layout: ASLayoutElement) -> AnyLayout<ASLayoutElement> {
        return AnyLayout(content: layout)
    }
    
    static func buildExpression(_ layout: HLayout) -> AnyLayout<ASLayoutElement> {
        return AnyLayout(content: layout.build())
    }
    
    static func buildExpression(_ layout: VLayout) -> AnyLayout<ASLayoutElement> {
        return AnyLayout(content: layout.build())
    }
    
    // MARK: Build If
    static func buildIf(_ layout: VLayout?)-> AnyLayout<ASLayoutElement> {
        if let layoutSpec = layout?.build() {
            return AnyLayout(content: layoutSpec)
        }
        
        return AnyLayout(content: ASLayoutSpec())
    }
    
    
    static func buildEither(first layout: VLayout)-> AnyLayout<ASLayoutElement> {
        return AnyLayout(content: layout.build())
    }
    
    static func buildEither(second layout: VLayout)-> AnyLayout<ASLayoutElement> {
        return AnyLayout(content: layout.build())
    }
}
