//
//  AttributedStringBuilder.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 17/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit


@_functionBuilder
struct AttributedStringBuilder {
    static func buildExpression(_ text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [:])
    }
    
    static func buildExpression(_ image: UIImage) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        return NSAttributedString(attachment: attachment)
    }
    
    static func buildExpression(_ attr: NSAttributedString) -> NSAttributedString {
        attr
    }
    
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        components.forEach(result.append)
        return result
    }
    
    static func buildBlock(_ text: String) -> NSAttributedString {
        return NSAttributedString(string: text)
    }
    
    static func buildIf(_ component: NSAttributedString?) -> NSAttributedString {
        return component ?? NSAttributedString()
    }
}

extension AttributedStringBuilder {
    static func buildExpression(_ text: Text) -> NSAttributedString {
        return text.getAttributedString()
    }
    
    static func buildExpression(_ image: Image)
        -> NSAttributedString {
            return image.getAttributedString()
    }
    
    static func buildExpression(_ link: Link)
        -> NSAttributedString {
            return link.getAttributedString()
    }
}


extension NSAttributedString {
    convenience init(@AttributedStringBuilder builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
    
    func withAttributes(_ attrs: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        copy.addAttributes(attrs, range: NSRange(location: 0, length: string.count))
        return copy
    }
}

struct Link {
    let url: String
    let label: String
    
    func getAttributedString() -> NSAttributedString {
       return NSAttributedString(string: label,
                                         attributes: [.link : url])
    }
}

struct Image {
    private let image: UIImage
    
    init(_ name: String) {
        image = UIImage(named: name) ?? UIImage()
    }
    
    func renderingMode(_ renderingMode: UIImage.RenderingMode) -> Self{
        image.withRenderingMode(renderingMode)
        return self
    }
    
    func getAttributedString() -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        return NSAttributedString(attachment: attachment)
    }
}


struct Text {
    private let attributedString: NSMutableAttributedString
    private var rangeString:NSRange{
        let range = 0..<attributedString.string.count
        return NSRange(range)
    }
    
    init(_ text: String) {
        self.attributedString = NSMutableAttributedString(string: text)
    }
    
    func font(_ font: UIFont) -> Self {
        self.attributedString
            .addAttributes([.font: font],
                           range: rangeString)
        return self
    }
    
    func color(_ color: UIColor) -> Self {
        self.attributedString
            .addAttributes([.foregroundColor: color],
                           range: rangeString)
        return self
    }
    
    func getAttributedString() -> NSAttributedString {
        return attributedString
    }
}
