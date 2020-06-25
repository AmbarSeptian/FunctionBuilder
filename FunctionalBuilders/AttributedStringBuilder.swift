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
        attachment.bounds = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        
        return NSAttributedString(attachment: attachment)
    }
    
    static func buildExpression(_ attr: NSAttributedString) -> NSAttributedString {
        attr
    }
    
    static func buildBlock(_ attrs: NSAttributedString...) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        attrs.forEach(result.append)
        return result
    }
    
    static func buildBlock(_ attr: NSAttributedString) -> NSAttributedString {
        return attr
    }
    
    static func buildBlock(_ text: String) -> NSAttributedString {
        return NSAttributedString(string: text)
    }
    
    static func buildIf(_ attr: NSAttributedString?) -> NSAttributedString {
        return attr ?? NSAttributedString()
    }
    
    static func buildEither(first attr: NSAttributedString) -> NSAttributedString {
        return attr
    }
    
    static func buildEither(second attr: NSAttributedString) -> NSAttributedString {
        return attr
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


