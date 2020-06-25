//
//  AttributeStringViewController.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 14/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

class AttributeStringViewController: UIViewController {
    
    var showLink = false
    var isFirstMemeUsed = false
    var isAlternativeBuilderUsed = false
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = false
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        return scrollView
    }()
    
    lazy var toggleAlternativeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.toggleAlternativeBuilder), for: .touchUpInside)
        button.setTitle("Toggle Alternative Builder", for: .normal)
        return button
    }()
    
    lazy var toggleLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.toggleShowLink), for: .touchUpInside)
        button.setTitle("Toggle Show Link", for: .normal)
        return button
    }()
    
    lazy var toggleMemeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(self.toggleMemeImage), for: .touchUpInside)
        button.setTitle("Toggle Show Meme", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        scrollView.addSubview(toggleAlternativeButton)
        scrollView.addSubview(toggleMemeButton)
        scrollView.addSubview(toggleLinkButton)
        applyAttributedStringBuilder()
    }
    
    func applyAttributedStringBuilder() {
        let attributedText = isAlternativeBuilderUsed ? generateAlternativeStringBuilder() :  generateDefaultStringBuilder()
        label.attributedText = attributedText
    }
    
    func generateDefaultStringBuilder() -> NSAttributedString {
        NSAttributedString {
            "Heading"
            "\n"
            "\n"
            NSAttributedString {
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
            }
            .withAttributes([.font: UIFont.systemFont(ofSize: 12)])
            "\n"
            "---------\n"
            if showLink {
                Link(url: "https://google.com", label: "Read more....")
            }
            "\n"
            "\n"
            if isFirstMemeUsed {
                UIImage(named: "meme1")!
            } else {
                UIImage(named: "meme2")!
            }
        }
    }
    
    func generateAlternativeStringBuilder() -> NSAttributedString {
        NSAttributedString {
            Heading("Heading")
            LineBreak()
            LineBreak()
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
                .color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            LineBreak()
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
                .color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
            LineBreak()
            Separator()
            "---------\n"
            if showLink {
                Link(url: "https://google.com", label: "Read more....")
            }
            LineBreak()
            LineBreak()
            if isFirstMemeUsed {
                Image("meme1")
            } else {
                Image("meme1")
            }
        }
    }
    
    @objc func toggleShowLink() {
        showLink.toggle()
        applyAttributedStringBuilder()
    }
    
    @objc func toggleMemeImage() {
        isFirstMemeUsed.toggle()
        applyAttributedStringBuilder()
    }
    
    @objc func toggleAlternativeBuilder() {
        isAlternativeBuilderUsed.toggle()
        applyAttributedStringBuilder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        label.frame = CGRect(x: 20,
                             y: 20,
                             width: view.bounds.width - 40,
                             height: 400)
        toggleLinkButton.frame = CGRect(x: 0,
                                        y: 450,
                                        width: view.bounds.width,
                                        height: 50)
        toggleMemeButton.frame = CGRect(x: 0,
                                        y: 500,
                                        width: view.bounds.width,
                                        height: 50)
        toggleAlternativeButton.frame = CGRect(x: 0,
                                               y: 550,
                                               width: view.bounds.width,
                                               height: 50)
    }
}
