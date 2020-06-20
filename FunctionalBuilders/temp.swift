////
////  temp.swift
////  FunctionalBuilders
////
////  Created by Ambar Septian on 21/06/20.
////  Copyright © 2020 Ambar Septian. All rights reserved.
////
//
//import AsyncDisplayKit
//
//protocol StackLayout: Layout {
//
//}
//
//
//extension ASDisplayNode: Layout {
//    func layoutSpec() -> ASLayoutElement {
//        return self
//    }
//    
//}
//
//extension ASStackLayoutSpec: Layout {
//    func layoutSpec() -> ASLayoutElement {
//         return self
//     }
//}
//
//
//@_functionBuilder
//struct LayoutBuilder {
//   static func buildExpression(_ layout: Layout) -> Layout {
//       return layout
//   }
//   
//   static func buildBlock(_ layouts: Layout...)-> VerticalLayout {
//       return VerticalLayout(layout: layouts)
//   }
//   
//   static func buildBlock(_ horizontals: Layout...)-> HorizontalLayout {
//        return HorizontalLayout(layout: horizontals)
//    }
//}
//
//
//protocol Layout {
//    func layoutSpec() -> ASLayoutElement
//}
//
//extension Layout {
//
//}
//
//
//struct VerticalLayout: StackLayout {
//    func layoutSpec() -> ASLayoutElement {
//        return stack
//    }
//
//    private var stack = ASStackLayoutSpec()
//
//    init(layout: ASStackLayoutSpec) {
//        self.stack = layout
//    }
//
//    init(verticalLayout: VerticalLayout) {
//        self.stack = verticalLayout.layoutSpec() as! ASStackLayoutSpec
//    }
//
//    init(@LayoutBuilder builder: () -> VerticalLayout) {
//        self.init(layout: builder())
//    }
//
//    func spacing(_ spacing: CGFloat) -> Self {
//        self.stack.spacing = spacing
//        return self
//    }
//
//    func alignItems(_ alignItems: ASStackLayoutAlignItems) -> Self {
//        self.stack.alignItems = alignItems
//        return self
//    }
//
//    func justifyContent(_ justifyContent: ASStackLayoutJustifyContent) -> Self {
//         self.stack.justifyContent = justifyContent
//         return self
//     }
//
//    func build() -> ASLayoutSpec {
//        return stack
//    }
//}
//
//struct HorizontalLayout: StackLayout {
//    func layoutSpec() -> ASLayoutElement {
//        return stack
//    }
//
//    private var stack = ASStackLayoutSpec()
//
//    init(layout: [Layout]) {
//        self.stack = ASStackLayoutSpec.horizontal()
//        self.stack.children = layout.map { $0.layoutSpec() }
//    }
//
//    init(verticalLayout: HorizontalLayout) {
//        self.stack = verticalLayout.layoutSpec() as! ASStackLayoutSpec
//    }
//
//    init(@LayoutBuilder builder: () -> HorizontalLayout) {
//        self.init(verticalLayout: builder())
//    }
//
//    func spacing(_ spacing: CGFloat) -> Self {
//        self.stack.spacing = spacing
//        return self
//    }
//
//    func alignItems(_ alignItems: ASStackLayoutAlignItems) -> Self {
//        self.stack.alignItems = alignItems
//        return self
//    }
//
//    func justifyContent(_ justifyContent: ASStackLayoutJustifyContent) -> Self {
//         self.stack.justifyContent = justifyContent
//         return self
//     }
//
//    func build() -> ASLayoutSpec {
//        return stack
//    }
//}
//
//
//
//class LayoutSpec: ASWrapperLayoutSpec {
//    convenience init(@LayoutBuilder builder: () -> Layout) {
//        self.init(layoutElement: builder().layoutSpec())
//    }
//}
