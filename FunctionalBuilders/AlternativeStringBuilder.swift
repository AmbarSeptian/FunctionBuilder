//
//  AlternativeStringBuilder.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 25/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

extension AttributedStringBuilder {
    static func buildExpression(_ text: Text) -> NSAttributedString {
        return text.getAttributedString()
    }
    
    static func buildExpression(_ image: Image) -> NSAttributedString {
            return image.getAttributedString()
    }
    
    static func buildExpression(_ link: Link)  -> NSAttributedString {
            return link.getAttributedString()
    }
    
    static func buildExpression(_ heading: Heading) -> NSAttributedString {
        return heading.getAttributedString()
    }
    
    static func buildExpression(_ separator: Separator) -> NSAttributedString {
        return separator.getAttributedString()
    }
    
    static func buildExpression(_ lineBreak: LineBreak) -> NSAttributedString {
        return lineBreak.getAttributedString()
    }
    
    // You can use protocol instead :)
    static func buildExpression(_ component: StringComponent) -> NSAttributedString {
        return component.getAttributedString()
    }
}

protocol StringComponent {
    func getAttributedString() -> NSAttributedString
}

struct Link: StringComponent {
    let url: String
    let label: String
    
    func getAttributedString() -> NSAttributedString {
       return NSAttributedString(string: label,
                                         attributes: [.link : url])
    }
}

struct Image: StringComponent {
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
        attachment.bounds = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        return NSAttributedString(attachment: attachment)
    }
}


struct Text: StringComponent {
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

struct Heading: StringComponent {
    private let attributedString: NSMutableAttributedString
    private var rangeString:NSRange{
        let range = 0..<attributedString.string.count
        return NSRange(range)
    }
    
    init(_ text: String) {
        self.attributedString = NSMutableAttributedString(string: text,
                                                          attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
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

struct LineBreak: StringComponent {
    let text = "\n"
    
    func getAttributedString() -> NSAttributedString {
        return NSAttributedString(string: text)
    }
}

struct Separator: StringComponent {
    let text = "---------"
    
    func getAttributedString() -> NSAttributedString {
        return NSAttributedString(string: text)
    }
}

